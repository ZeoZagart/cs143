 
class LinkedList {
    
    item: Object;
    next: LinkedList;
    prev: LinkedList;
    null: LinkedList;
    
    init(i: Object): LinkedList {
        {
            item <- i;
            self;
        }
    };
    
    setPrev(prevElem: LinkedList): LinkedList {
        {
            prev <- prevElem;
            self;
        }
    };
    
    voidNext(): LinkedList {
        {
            next <- null;
            self;
        }
    };
    
    push(i: Object): LinkedList {
        (let nextItem: LinkedList in
        {
            nextItem <- (new LinkedList).init(i).setPrev(self);
            next <- nextItem;
            self;
        })
    };
    
    getItem(): Object {
        {
            item;
        }
    };
    
    getNext(): LinkedList {
        {
            next;
        }
    };
    
    getPrev(): LinkedList {
        {
            prev;
        }
    };

};
