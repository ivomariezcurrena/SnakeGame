

Program Snakegame;
// Zach Dobbs
// Started on - 4/22/2014
// Last update - 8/19/2014
// Created Junior Year, 2014 - RBHS
// Generic snake game, made to test ability in coding

Uses crt;

Var 
    speed:   integer;
    // Speed of snake
    diff:   char;
    // Difference
    score:   integer;
    // Score
    quit:   boolean;
    // Restarts the program
    gamemode:   integer;
    // Mode selector
    snakecolor:   integer;
    // Color of snake
    CChoice:   char;
    // Choice of color
    ee:   boolean;
    // Easter egg

Procedure startscreen();
// The first screen to appear

Var 
    SSx:   integer;
    // X coord
    SSy:   integer;
    // Y coord
    SSybool:   boolean;
    // Checks to make sure SSy is not on the title
Begin
    // Begin startscreen
    Repeat
        // Begin print
        gotoxy(35,12);
        writeln('SNAKE');
        gotoxy(32,13);
        writeln('PRESS ENTER');
        Repeat
            // Begin finding random spot
            SSybool := FALSE;
            SSx := random(79)+1;
            SSy := random(24)+1;
            If (SSy>14) Or (SSy<11) Then SSybool := true
        Until SSybool=TRUE;
        // End finding random spot
        gotoxy(SSx,SSy);
        textcolor(random(9)+8);
        write('o');
        delay(10)
    Until keypressed // End print
End;
// End startscreen



Procedure MOVE(MVEspeed:integer; Var MVElink:integer; MVEmode:integer);
// Main procedure, basically the entire snake game

Var 
    MVEwhere:   char;
    // moves where?
    // M = >
    // K = <
    // H = V
    // P = ^
    MVEquit:   boolean;
    // quits
    MVEX:   array[1..100] Of integer;
    // x
    MVEY:   array[1..100] Of integer;
    // y
    MVEXDOT:   array[1..3] Of integer;
    // x to get
    MVEYDOT:   array[1..3] Of integer;
    // y to get
    MVEBX:   array[1..3] Of integer;
    // X of bombs
    MVEBY:   array[1..3] Of integer;
    // Y of bombs
    MVEkey:   char;
    // Direction
    MVEi:   integer;
    // counts
    MVEprev:   char;
    // Backup for direction
    MVEtally:   integer;
    // Keeps track of movement for bombs
    MVEbombnum:   integer;
    // Num of bomb being dropped
    MVEsec:   integer;
    // Seconds
Begin
    // Begin MVE
    MVEquit := false;
    MVElink := 4;
    cursoroff;
    MVEtally := 0;
    MVEbombnum := 1;
    MVEX[1] := 30;
    MVEY[1] := 15;
    MVEsec := 5;
    MVEkey := 'M';
    MVEprev := MVEkey;

    For MVEi:=1 To 3 Do
        Begin
            // Fills random dots for segment
            MVEXDOT[MVEi] := random(80)+1;
            MVEYDOT[MVEi] := random(25)+1;
            MVEBX[MVEi] := random(80)+1;
            MVEBY[MVEi] := 1
        End;
    // End random dot filling

    Repeat
        // Begin game loop
        Repeat
            // Begin moving

            If ee Then snakecolor := random(9)+8;
            For MVEi:=MVElink Downto 2 Do
                Begin
                    // Move segments
                    MVEX[MVEi] := MVEX[MVEi-1];
                    MVEY[MVEi] := MVEY[MVEi-1]
                End;
            // End move

            Case MVEkey Of 
                // Change pos of head
                'M':   MVEX[1] := MVEX[1]+1;
                'K':   MVEX[1] := MVEX[1]-1;
                'H':   MVEY[1] := MVEY[1]-1;
                'P':   MVEY[1] := MVEY[1]+1;
                'q':   MVEquit := true;
                Else
                    MVEkey := MVEprev;
                // Prevents pausing game
                Case MVEkey Of 
                    // Change pos of head
                    'M':   MVEX[1] := MVEX[1]+1;
                    'K':   MVEX[1] := MVEX[1]-1;
                    'H':   MVEY[1] := MVEY[1]-1;
                    'P':   MVEY[1] := MVEY[1]+1;
                    'q':   MVEquit := true
                End
                // end inner case
            End;
            // end outer case

            For MVEi:=1 To 3 Do
                Begin
                    // Begin placing random dots
                    gotoxy(MVEXDOT[MVEi],MVEYDOT[MVEi]);
                    textcolor(yellow);
                    write('o')
                End;
            // end place dots

            For MVEi:=1 To 3 Do
                Begin
                    // Check if head of snake has hit a dot
                    If (MVEX[1]=MVEXDOT[MVEi]) And (MVEY[1]=MVEYDOT[MVEi]) Then
                        Begin
                            // begin if
                            MVElink := MVElink+1;
                            MVEsec := 5;
                            MVEXDOT[MVEi] := random(80)+1;
                            MVEYDOT[MVEi] := random(25)+1
                        End
                        // end inner if
                End;
            // end outer if

            MVEprev := MVEkey;
            // Prevents pausing of game by spamming keys

            If (MVEX[1]=MVEX[3]) And (MVEY[1]=MVEY[3]) Then
                Begin
                    // Prevents user from accidently colliding on back segment
                    Case MVEkey Of 
                        // Checks if Opposite key has been pressed
                        'M':
                               Begin
                                   MVEkey := 'K';
                                   MVEX[1] := MVEX[1]-2
                               End;
                        'K':
                               Begin
                                   MVEkey := 'M';
                                   MVEX[1] := MVEX[1]+2
                               End;
                        'H':
                               Begin
                                   MVEkey := 'P';
                                   MVEY[1] := MVEY[1]+2
                               End;
                        'P':
                               Begin
                                   MVEkey := 'H';
                                   MVEY[1] := MVEY[1]-2
                               End
                    End
                    // End case
                End;
            // End prevention check

            For MVEi:=2 To MVElink Do
                Begin
                    // Check if head has hit segment
                    If (MVEX[1]=MVEX[MVEi]) And (MVEY[1]=MVEY[MVEi]) Then
                        MVEquit := TRUE
                End;
            // end head check

            For MVEi:=2 To MVElink Do
                Begin
                    // Write segments
                    gotoxy(MVEX[MVEi],MVEY[MVEi]);
                    textcolor(snakecolor);
                    write('o')
                End;
            // end write segments

            gotoxy(MVEX[1],MVEY[1]);
            textcolor(snakecolor);
            write('o');
            // Write head

            If MVEmode=1 Then // BOMB MODE
                Begin
                    // DROP BOMBS!
                    MVEtally := MVEtally+1;

                    For MVEi:=1 To 3 Do
                        Begin
                            // Begin writing bombs
                            gotoxy(MVEBX[MVEi],MVEBY[MVEi]);
                            textcolor(lightred);
                            write('o')
                        End;
                    // End writing bombs

                    For MVEi:=1 To MVEbombnum Do
                        Begin
                            // Change bomb position
                            MVEBY[MVEi] := MVEBY[MVEi]+1;
                            If MVEBY[MVEi]=25 Then
                                Begin
                                    // Reset bomb position
                                    MVEBY[MVEi] := 1;
                                    MVEBX[MVEi] := random(80)+1
                                End
                                // End bomb position
                        End;
                    // End bomb pos change

                    If MVEtally=10 Then
                        Begin
                            // Tells other bombs to start dropping
                            MVEbombnum := MVEbombnum+1;
                            If MVEbombnum=4 Then MVEbombnum := 3;
                            MVEtally := 0
                        End;
                    // End the bomb num drops

                    For MVEi:=1 To MVElink Do
                        Begin
                            // Check if snake hit bomb
                            If (MVEX[MVEi]=MVEBX[1]) And (MVEY[MVEi]=MVEBY[1])
                                Then MVEquit := TRUE;
                            If (MVEX[MVEi]=MVEBX[2]) And (MVEY[MVEi]=MVEBY[2])
                                Then MVEquit := TRUE;
                            If (MVEX[MVEi]=MVEBX[3]) And (MVEY[MVEi]=MVEBY[3])
                                Then MVEquit := TRUE
                        End
                        // End check
                End;
            // End bomb mode

            If MVEmode=3 Then // TIME MODE
                Begin
                    // Begin timer
                    MVEtally := MVEtally+1;
                    If MVEtally=20 Then
                        Begin
                            // Change second
                            MVEsec := MVEsec-1;
                            MVEtally := 1;
                        End;
                    // End change second
                    If MVEsec=0 Then MVEquit := TRUE;
                    gotoxy(40,2);
                    Textcolor(lightcyan);
                    writeln(MvEsec)
                End;
            // End time

            If (MVEX[1]=81) Or (MVEX[1]=0) Or (MVEY[1]=0) Or (MVEY[1]=26) Then
                Begin
                    // Check if snake has hit wall of screen
                    If (MVEmode=2) Or (MVEmode=3) Then // LOOP MODE
                        Begin
                            // Begin loop mode commands
                            Case MVEX[1] Of 
                                // Change x pos of head
                                81:   MVEX[1] := 1;
                                0:   MVEX[1] := 80
                            End;
                            // End x pos
                            Case MVEY[1] Of 
                                // Change y pos of head
                                26:   MVEY[1] := 1;
                                0:   MVEY[1] := 25
                            End
                            // End y pos
                        End
                        // End loop mode
                    Else
                        MVEquit := TRUE;
                End;
            // End check
            delay(MVEspeed);
            clrscr;
        Until keypressed Or MVEquit;
        // End moving
        textcolor(yellow);
        If MVEquit=TRUE Then writeln('GAME OVER               Press Enter');
        MVEkey := readkey;
    Until MVEquit;
    // End game
End;
// End MOVE



Procedure restart(Var RSTquit: boolean);
// Determines if a restart is called

Var 
    RSTchar:   char;
    // Y or N
Begin
    // Begin restart
    RSTquit := false;
    Repeat
        // Waits for valid input
        writeln('Would you like to play again?');
        write('Please type y to restart or n to quit: ');
        readln(RSTchar);
        If (RSTchar='n') Or (RSTchar='N') Then RSTquit := TRUE;
        clrscr
    Until (RSTchar='y') Or (RSTchar='Y') Or RSTquit // Exits at valid input
End;
// End restart



Procedure SCOREME(SEscore: integer; SEdiff: char);
// Displays high scores

Var 
    SEfile:   text;
    // File containing scores
    SElist:   array[1..7] Of integer;
    // high scores
    SEi:    integer;
    // Counts
    SEj:    integer;
    // Also counts
    SEh:    integer;
    // Also also counts
    SEname:   array[1..7] Of string;
    // name of high score holders
    SEtemp:   integer;
    // Placeholder variable
    SEuser:   string;
    // Name of user
    SEhold:   string;
    // name placeholder
    SEhigh:   boolean;
    // Determines if there is a new high score
Begin
    SEj := 1;
    SEh := 1;
    SEhigh := FALSE;
    Case SEdiff Of 


// Assigns path of highscore files, currently needs to be changed upon changing computers
        'E','e':   assign(SEfile,

                  'C:\Users\Zach\Dropbox\Pascal\Snake\scoreboard\easy\score.txt'
                   );
        'M','m':   assign(SEfile,

                'C:\Users\Zach\Dropbox\Pascal\Snake\scoreboard\medium\score.txt'
                   );
        'H','h':   assign(SEfile,

                  'C:\Users\Zach\Dropbox\Pascal\Snake\scoreboard\hard\score.txt'
                   );
        'B','b':   assign(SEfile,

                  'C:\Users\Zach\Dropbox\Pascal\Snake\scoreboard\bomb\score.txt'
                   );
        'L','l':   assign(SEfile,

                  'C:\Users\Zach\Dropbox\Pascal\Snake\scoreboard\loop\score.txt'
                   );
        'T','t':   assign(SEfile,

                  'C:\Users\Zach\Dropbox\Pascal\Snake\scoreboard\time\score.txt'
                   )
    End;
    // End assigning
    reset(SEfile);
    For SEi:=1 To 10 Do
        Begin
            // Begin reading files
            If (SEi Mod 2 = 1) Then
                Begin
                    // Get names
                    readln(SEfile,SEname[SEj]);
                    SEj := SEj+1
                End
                // End names
            Else
                Begin
                    // Get scores
                    readln(SEfile,SElist[SEh]);
                    SEh := SEh+1
                End
                // End scores
        End;
    // End reading file
    close(SEfile);
    For SEi:=1 To 5 Do
        Begin
            // Begin high check
            If SEscore>=SElist[SEi] Then SEhigh := TRUE
        End;
    // End high check
    If SEhigh=TRUE Then
        Begin
            // Allow user to input name
            writeln('NEW HIGH SCORE!');
            write('ENTER YOUR NAME: ');
            readln(SEuser)
        End;
    // end input
    For SEi:=1 To 5 Do
        Begin
            // Begin changing scores
            If SEscore>SElist[SEi] Then
                Begin
                    // Changes the pos if new high score
                    SEtemp := SElist[SEi];
                    SElist[SEi] := SEscore;
                    SEscore := SEtemp;
                    SEhold := SEname[SEi];
                    SEname[SEi] := SEuser;
                    SEuser := SEhold
                End
                // End change
        End;
    // End score changes
    SEj := 1;
    SEh := 1;
    rewrite(SEfile);
    For SEi:=1 To 10 Do
        Begin
            // Rewrite highscore file
            If (SEi Mod 2 = 1) Then
                Begin
                    // Write name
                    writeln(SEfile,SEname[SEj]);
                    SEj := SEj+1
                End
                // End name
            Else
                Begin
                    // Write score
                    writeln(SEfile,SElist[SEh]);
                    SEh := SEh+1
                End
                // End score
        End;
    // End rewriting
    close(SEfile);
    textcolor(lightgray);
    write('HIGH SCORES FOR ');
    Case diff Of 
        // Write score chosen
        'E','e':   write('EASY');
        'M','m':   write('MEDIUM');
        'H','h':   write('HARD');
        'B','b':   write('BOMB');
        'L','l':   write('LOOP');
        'T','t':   write('TIME ATTACK');
    End;
    // End writing
    writeln(' MODE');
    writeln;
    For SEi:=1 To 5 Do
        Begin
            // Begin displaying high scores
            textcolor(lightgray);
            write(SEi,':   ',SEname[SEi],' - ');
            textcolor(yellow);
            writeln(SElist[SEi])
        End
        // End high score display
End;



Begin
    // Begin MAIN
    Repeat
        // Begin main repeat
        randomize;
        snakecolor := 10;
        score := 0;
        speed := 0;
        ee := FALSE;
        gamemode := 0;
        cursoroff;
        startscreen;
        clrscr;
        textcolor(lightgray);
        writeln('Press enter');
        readln;
        Repeat;
            // Main display, prompts for difficulty
            clrscr;
            gotoxy(15,1);
            textcolor(lightgreen);
            writeln('SNAKE');
            gotoxy(12,2);
            writeln('ZACH DOBBS');
            gotoxy(1,5);
            textcolor(yellow);
            writeln('Welcome to the Snake game!');
            textcolor(lightgray);
            write('You will control a snake ');
            textcolor(snakecolor);
            write('oooo ');
            writeln;
            textcolor(lightgray);
            write('and attempt to eat all the dots ');
            textcolor(yellow);
            write('o');
            writeln;
            textcolor(lightgray);
            writeln('Every dot you eat will make your snake longer.');
            write('In bomb mode, you must avoid falling bombs ');
            textcolor(lightred);
            write('o');
            textcolor(lightgray);
            writeln;
            writeln(

      'In loop mode and time mode, you only lose by hitting yourself, not walls'
            );
            writeln('In time attack mode, you have 5 seconds to get a dot');
            writeln('You control your snake with the arrow keys.');
            writeln(

              'You will lose the game if your snake hits the edge of the screen'
            );
            writeln('or the snake hits itself.');
            writeln('You may quit the game at any time by pressing the q key.');
            writeln('Your score will be displayed at the end of the game.');
            writeln;
            textcolor(yellow);
            writeln('SELECT YOUR DIFFICULTY');
            writeln('Easy, Medium, Hard, Bomb, Loop, or Time Attack Mode?');
            writeln('Type option to change snake color.');
            cursoron;
            readln(diff);
            Case diff Of 
                // Choices for gamemodes
                'E','e':   speed := 100;
                'M','m':   speed := 70;
                'H','h':   speed := 40;
                'B','b':
                           Begin
                               // Same speed as medium, drops bombs
                               speed := 70;
                               gamemode := 1
                           End;
                // end bomb
                'L','l':
                           Begin
                               // Higher speed than medium, no collision
                               speed := 50;
                               gamemode := 2
                           End;
                // end loop
                'O','o':
                           Begin
                               // Choose color
                               clrscr;
                               writeln('Select the color of your snake!');
                               writeln;
                               writeln;
                               textcolor(lightmagenta);
                               writeln('	Purple');
                               textcolor(lightgreen);
                               writeln('	Green');
                               textcolor(red);
                               writeln('	Red');
                               textcolor(yellow);
                               writeln('	Yellow');
                               textcolor(white);
                               writeln('	White');
                               textcolor(lightcyan);
                               writeln('	Blue');
                               writeln;
                               textcolor(lightgray);
                               write('Make your selection: ');
                               readln(CChoice);
                               Case CChoice Of 
                                   // Choices of color
                                   'P','p':   snakecolor := 13;
                                   'G','g':   snakecolor := 10;
                                   'R','r':   snakecolor := 4;
                                   'Y','y':   snakecolor := 14;
                                   'W','w':   snakecolor := 15;
                                   'B','b':   snakecolor := 11;
                                   '*':   ee := TRUE;
                               End;
                               // End choice of color
                           End;
                // End choose color
                'T','t':
                           Begin


                           // Higher speed than medium, time limit, no collision
                               speed := 50;
                               gamemode := 3
                           End
            End
            // End choices
        Until (speed>0);
        // Repeats until a valid gamemode has been selected
        MOVE(speed,score,gamemode);
        cursoron;
        clrscr;
        textcolor(lightgray);
        write('Score: ');
        textcolor(yellow);
        write(score);
        writeln;
        textcolor(lightgray);
        write('Difficulty: ');
        textcolor(yellow);
        Case diff Of 
            // Write difficulty
            'E','e':   write('EASY');
            'M','m':   write('MEDIUM');
            'H','h':   write('HARD');
            'B','b':   write('BOMB');
            'L','l':   write('LOOP');
            'T','t':   write('TIME ATTACK')
        End;
        // End writing difficulty
        writeln;
        writeln;
        SCOREME(score,diff);
        writeln;
        restart(quit);
    Until quit;
    // End main repeat block, program will end
End.
// END MAIN
