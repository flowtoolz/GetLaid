/** TODO: `infix operator >>: AssignmentPrecedence` does not work anywhere. since we heavily overload the operator, trying to declare precedence creates ambiguity compile errors ...
 
 example use case: brackets around the multiplication should be unnecessary: `(view.height >> (defaultHeight * 1.3)).priority = .init(999)`
*/
//infix operator >>: AssignmentPrecedence
