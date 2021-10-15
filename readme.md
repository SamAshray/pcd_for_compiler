#   CSPC41 Compiler Design Project Assignment

## Project - 4
## Simulation of front-end phase of C Compiler involving for construct.

### Instructions to run
-   Clone the repository
-   Run 
    ```bash
    cd pcd_for_compiler
    make
    ```
-   Enter your for loop when prompted
    ```bash
    Enter the expression:
    for(i=0;i<7;i++)j=j+1;
    ```
-   Sample output:
    ```bash
    L1: 
            i = 0
            t0 = i < 7
            t1 = not t0
            if t1 goto END
            goto BODY

            UPDATE: 
                    t2 = i + 1
                    i = t2
                    goto L1

            BODY: 
                    t3 = j + 1
                    j = t3
                    goto UPDATE

    END: 
            end of for loop 

    Input accepted
    ```
Explanation:

- Lexical Analysis: Generation of tokens in for.l using regular expressions. 

- Syntax Analysis: Created grammar for entire C code that has FOR construct.

- Intermediate Code Generation: Generated intermediate code on the fly.

---
Contributors:

-   CSE18U004   -   Bhokya Uday Chandra
-   CSE18U014	-   Konala Sam Ashray
-   CSE18U021   -   Panta DattatreyaReddy
-	CSE18U028   -   V Subhash