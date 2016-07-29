Box-Cox transformation
$$ w_t  = \begin{cases} \log(y_t) & \text{if $\lambda=0$};  \\ (y_t^\lambda-1)/\lambda & \text{otherwise}. \end{cases}$$
  Box-Cox back-transformation
$$ y_{t} = \begin{cases} \exp(w_t) & \text{if $\lambda=0$}; \\ (\lambda w_t+1)^{1/\lambda} & \text{otherwise}.\end{cases} $$