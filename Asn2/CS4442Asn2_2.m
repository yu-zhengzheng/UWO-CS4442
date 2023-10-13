x=[ 3	0	6
    0	5	0
    3	8	0];
z=x';

kernel_matrix_k3=(x*z)
eig(kernel_matrix_k3)
kernel_matrix_sqrtk3=sqrt((x*z))
eig(kernel_matrix_sqrtk3)
