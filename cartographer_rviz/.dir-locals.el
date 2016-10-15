((c++-mode . ((eval .
                    (let ((project-dir (expand-file-name (locate-dominating-file buffer-file-name ".dir-locals.el")))
                          include-dirs
                          clang-args)
                      (cond ((eq system-type 'darwin)
                             (setq include-dirs
                                   `(,(concat project-dir "")
                                     ,(concat project-dir "../../../build_isolated/cartographer_ros/")
                                     ,(concat project-dir "build")
                                     "/usr/local/include/eigen3"
                                     "/usr/local/include/pcl-1.8"
                                     "/usr/local/include/OGRE"
                                     "/opt/ros/jade/include"
                                     "/scratch/personal/Dropbox/programming/cv/gtest/googlemock/include"
                                     "/usr/local/include"))
                             (setq clang-args '("-std=c++11" "-stdlib=libc++" "-DBOOST_NO_EXCEPTIONS" "-DQT_CORE_LIB" "-DQT_GUI_LIB" "-DQT_NO_DEBUG" "-DQT_NO_KEYWORDS" "-DROSCONSOLE_BACKEND_LOG4CXX" "-DROS_PACKAGE_NAME=\"cartographer_rviz\"" "-Dcartographer_rviz_submaps_visualization_EXPORTS" "-isysroot" "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk" "-iframework" "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/System/Library/Frameworks" "-isystem" "/usr/local/Cellar/qt/4.8.7_2/include" "-iframework" "/usr/local/Cellar/qt/4.8.7_2/lib" "-isystem" "/usr/local/Cellar/qt/4.8.7_2/include/QtGui" "-isystem" "/usr/local/Cellar/qt/4.8.7_2/lib/QtCore.framework/Headers")))
                            ((eq system-type 'gnu/linux)
                             (setq include-dirs
                                   `(,(concat project-dir "include")
                                     ,(concat project-dir "build/src")
                                     "/usr/include"
                                     "/usr/local/include"
                                     "/usr/include/x86_64-linux-gnu"
                                     "/scratch/progs/llvm/lib/clang/3.8.0/include"
                                     "/usr/include/c++/4.9"                                     
                                     "/usr/include/x86_64-linux-gnu/c++/4.9"
                                     "/usr/lib/gcc/x86_64-linux-gnu/4.9/include-fixed"
                                     "/usr/include/hdf5/serial"
                                     "/usr/local/cuda/include"
                                     "/opt/intel/mkl/include"))
                             (setq clang-args '("-std=c++11" "-stdlib=libc++" "-DQT_CORE_LIB" "-DQT_GUI_LIB" "-DQT_NO_DEBUG" "-DQT_NO_KEYWORDS" "-DROSCONSOLE_BACKEND_LOG4CXX" "-DROS_PACKAGE_NAME=\"cartographer_rviz\"" "-Dcartographer_rviz_submaps_visualization_EXPORTS"))))
                      (setq flycheck-clang-include-path include-dirs)
                      (setq flycheck-clang-warnings '("all" "extra" "no-sign-compare"))
                      (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
                      (setq ac-clang-flags (append (append clang-args (mapcar (lambda (x) (concat "-I" x)) include-dirs)) '("-target-cpu" "core-avx2")))
                      (setq c-eldoc-includes (concat (mapconcat #'identity clang-args " ")
                                                     " " (mapconcat (lambda (x) (concat "-I" x)) include-dirs " ")))
                      (setq flycheck-clang-args (append clang-args '("-march=core-avx2"))))))))
