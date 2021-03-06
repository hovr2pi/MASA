
// example of a private method, called from exact_t
double helper_func_an(double x)
{

  double func;
  func = x+12.4;
  return func;

}

// example of a public method called from eval_exact_t
double eval_exact_u(double x)
{
  double exact_u;
  exact_u = x*x;
  return exact_u;
}

// public method
double eval_exact_t(double x)
{
  double exact_t;
  exact_t = helper_func_an(x)*std::cos(A_x * x)*eval_exact_u(x);
  return exact_t;
}

