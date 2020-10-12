(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *  Skeleton file
 *)
 
 class Stack {
    
    itemList: LinkedList;
    io: IO <- new IO;
    
    init(value: Object): Stack {
        {
            itemList <- (new LinkedList).init(value);
            self;
        }
    };
    
    push(value: Object): Int {
        {
            itemList.push(value);
            itemList <- itemList.getNext();
            0;
        }
    };
    
    pop(): Object {
        (let last: Object in
        {
            last <- itemList.getItem();
            itemList <- itemList.getPrev();
            itemList.voidNext();
            last;
        })
    };
    
    printList(): Object {
        {
            printRecr(itemList);
            0;
        }
    };
    
    printRecr(item: LinkedList): Int {
        (let prevItem: LinkedList in
        {
            case item.getItem() of
                i: Int => io.out_int(i);
                c: String => io.out_string(c);
            esac;
            prevItem <- item.getPrev();
            if (isvoid prevItem) then
                0
            else
                printRecr(item.getPrev())
            fi;
            0;
        })
    };
};
