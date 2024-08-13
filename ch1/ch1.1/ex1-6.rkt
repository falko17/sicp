#|
(Skipping the ones before 1.6, wrote them down elsewhere)

Exercise 1.6:
`if` needs to be a special form because the operands must not be evaluated unless their corresponding condition is true.
For example, in the given sqrt-iter program, the recursive call would be evaluated every time sqrt-iter is called, which leads to an infinite recursion.
|#
