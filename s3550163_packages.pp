# this class ensures all of the required packages are installed
class packages {
  
  # ensure that all of the following packages in the below array are installed
  # installing 'csh' package as this will be used by Fred for his shell
  Package { ensure => 'installed' }
    
    $packages = [ 'hiera', 'csh', 'openssh', 'tmux', 'mariadb', 'mariadb-server', 'vnc-server', 'gcc', 'gdb', 'cgdb', 'dia', 'vim', 'emacs' ]
    package { $packages: }

}

