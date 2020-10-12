class Main {
    stack: Stack <- new Stack;
    io: IO <- new IO;
    a2i: A2I <- new A2I;
    
	main() : Object {
        (let inp: String in
        (let value: Int in
        {
            stack.init(0).push(0)
            io.out_string("Interpreter Started");
            {
                while ( not (1 = 0)) loop
                    {
                        io.out_string(">");
                        inp <- io.in_string();
                        if inp = "+" then stack.push("+") else
                        if inp = "s" then stack.push("s") else
                        if inp = "e" then execute(stack) else
                        if inp = "d" then stack.printList() else
                        if inp = "x" then abort() else
                        {
                            value <- a2i.a2i(inp);
                            stack.push(value);
                            0;
                        }
                        fi fi fi fi fi;
                        0;
                    }
                pool;
                0;
            };
        } ) )
    };
    
    execute(stack : Stack) : Int {
        (let top: Object in
        {
            top <- stack.pop();
            case top of
                i: Int => stack.push(i);
                c: String =>
                    {
                        if c = "+" then
                            addLastTwo(stack)
                        else
                            swapLastTwo(stack)
                        fi;
                    };
            esac;
            0;
        })
    };
    
    addLastTwo(stack: Stack): Int {
        (let top: Object in
        (let belowTop: Object in
        (let p: Int in
        (let q: Int in
        (let sum: Int in
        {
            top <- stack.pop();
            belowTop <- stack.pop();
            p <- 0;
            q <- 0;
            case top of
                i: Int => { p <- i; 0;};
                c: String => { abort(); 0; };
            esac;
            case belowTop of
                i2: Int => { q <- i2; 0;};
                c2: String => { abort(); 0; };
            esac;
            sum <- p + q;
            stack.push(sum);
            0;
        })))))
    };
    
    swapLastTwo(stack: Stack): Int {
        (let top: Object in
        (let belowTop: Object in
        {
            top <- stack.pop();
            belowTop <- stack.pop();
            stack.push(top);
            stack.push(belowTop);
            0;
        }))
    };
};
