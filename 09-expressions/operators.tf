locals {
  math       = 2 * 2                  # Math operators *, /, +, -, -<number>, % | returns number
  equality   = 2 == 2                 #  Equality operators: ==, != | returns boolean
  comparison = 2 > 1                  # Comparison operators: >, >=, <, <= | returns boolean
  logical    = !true || false && true # Logical operators: !, ||, && | returns boolean
}

output "operators" {
  value = {
    math       = local.math
    equality   = local.equality
    comparison = local.comparison
    logical    = local.logical
  }
}
