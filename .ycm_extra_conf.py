import os
import logging
import ycm_core
import re

BASE_FLAGS = [
    '-xc++',
    #'-std=c++11',
    '-W',
    '-Wall',
    '-D_GNU_SOURCE',

    '-isystem',
    '/usr/include/c++/3.4.5',
    '-isystem',
    '/usr/lib/gcc/x86_64-redhat-linux/3.4.5/../../../../include/c++/3.4.5',
    '-isystem',
    '/usr/lib/gcc/x86_64-redhat-linux/3.4.5/../../../../include/c++/3.4.5/x86_64-redhat-linux',
    '-isystem',
    '/usr/lib/gcc/x86_64-redhat-linux/3.4.5/../../../../include/c++/3.4.5/backward',
    '-isystem',
    '/usr/local/include',
    '-isystem',
    '/usr/lib/gcc/x86_64-redhat-linux/3.4.5/include',
    '-isystem',
    '/usr/include',
]


def FindNearest(path, target):
    candidate = os.path.join(path, target)
    if(os.path.isfile(candidate) or os.path.isdir(candidate)):
        logging.info("Found nearest " + target + " at " + candidate)
        return candidate;
    else:
        parent = os.path.dirname(os.path.abspath(path));
        if(parent == path):
            raise RuntimeError("Could not find " + target);
        return FindNearest(parent, target)

def MakeRelativePathsInFlagsAbsolute(flags, working_directory):  
    if not working_directory:
        return list(flags)
    new_flags = []
    make_next_absolute = False
    path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
    for flag in flags:
        new_flag = flag
        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)
        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True

            if flag.startswith(path_flag):
                path = flag[ len(path_flag): ]
                new_flag = path_flag + os.path.join(working_directory, path)
                break
        if new_flag:
            new_flags.append(new_flag)
    return new_flags

def FlagsForMakefile(root):
    try:
        makefile = FindNearest(root, 'Makefile')
        inc_pattern = re.compile(r'^INCPATH=(\S+(?:\s+\\\n\s+\S+)*)', re.M)
        dep_pattern = re.compile(r'^DEP_INCPATH=(\S+(?:\s+\\\n\s+\S+)*)', re.M)
        with open(makefile, 'r') as f:
            content = f.read()
            def FlagsForPattern(pattern):
                match = pattern.search(content)
                if match:
                    path_str = match.group(1)
                    path_list = [i.strip() for i in path_str.split('\\\n')]
                    return path_list
                else:
                    return []
            inc_path = FlagsForPattern(inc_pattern)
            dep_path = FlagsForPattern(dep_pattern)
            flags = inc_path + dep_path
            logging.info("Found Makefile flags: %s", flags)
            return MakeRelativePathsInFlagsAbsolute(flags, os.path.dirname(makefile))
    except:
        return None

def FlagsForInclude(root):  
    try:
        include_path = FindNearest(root, 'include')
        flags = []
        for dirroot, dirnames, filenames in os.walk(include_path):
            for dir_path in dirnames:
                real_path = os.path.join(dirroot, dir_path)
                flags = flags + ["-I" + real_path]
        return flags
    except:
        return None


def FlagsForFile(filename, **kwargs):
    root = os.path.realpath(filename)
    final_flags = BASE_FLAGS
    make_flags = FlagsForMakefile(root)
    if make_flags:
        final_flags += make_flags
    else:
        include_flags = FlagsForInclude(root)
        if include_flags:
            final_flags += include_flags
    return {
        'flags': final_flags,
        'do_cache': True
    }
