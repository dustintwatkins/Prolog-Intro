%Schools Out!

subject(english).
subject(gym).
subject(history).
subject(math).
subject(science).

state(california).
state(florida).
state(maine).
state(oregon).
state(virginia).

activity(antiquing).
activity(camping).
activity(sightseeing).
activity(spelunking).
activity(water_skiing).

name(appleton).
name(gross).
name(knight).
name(mcEvoy).
name(parnell).


solve :-

  subject(Appleton_subject),
  subject(Gross_subject),
  subject(Knight_subject),
  subject(Mcevoy_subject),
  subject(Parnell_subject),
  all_different([Appleton_subject, Gross_subject, Knight_subject, Mcevoy_subject, Parnell_subject]),

  state(Appleton_state),
  state(Gross_state),
  state(Knight_state),
  state(Mcevoy_state),
  state(Parnell_state),
  all_different([Appleton_state, Gross_state, Knight_state, Mcevoy_state, Parnell_state]),

  activity(Appleton_activity), activity(Gross_activity), activity(Knight_activity), activity(Mcevoy_activity), activity(Parnell_activity),
  all_different([Appleton_activity, Gross_activity, Knight_activity, Mcevoy_activity, Parnell_activity]),

  Groupings = [ [appleton, Appleton_subject, Appleton_state, Appleton_activity],
            [gross, Gross_subject, Gross_state, Gross_activity],
            [knight, Knight_subject, Knight_state, Knight_activity],
            [mcevoy, Mcevoy_subject, Mcevoy_state, Mcevoy_activity],
            [parnell, Parnell_subject, Parnell_state, Parnell_activity] ],

%Clue One
    %Gross_subject = math || Gross_subject = science
    %if Gross_activity = antiquing -> Gross_state = florida
      %else Gross_state = california

    %member(name, subject, state, activity)

    ( member([gross, math, _, _], Groupings) ; member([gross, science, _, _], Groupings) ),

    ( member([gross, _, florida, antiquing], Groupings) ; member([gross, _, california, _], Groupings) ),


%Clue Two
    %person_subject = science && person_activity = water_skiing
      %person_state = florida || person_state = california
    %Mcevoy_subject = history && Mcevoy_state = maine || Mcevoy_state = oregon

    ( member([_, science, florida, water_skiing], Groupings) ; member([_, science, california, water_skiing], Groupings) ),

    ( member([mcevoy, history, maine, _], Groupings) ; member([mcevoy, history, oregon, _], Groupings) ),


%Clue Three
    %(Appleton_state = virginia && Appleton_subject = english) || Parnell_state = virginia
    %Parnell_activity = spelunking

    ( member([appleton, english, virginia, _], Groupings) ; member([parnell, _, virginia, _], Groupings) ),
    member([parnell, _, _, spelunking], Groupings),

%Clue Four
    %person_state = maine && person_subject != gym && person_activity != sightseeing

    \+ member([_, _, maine, sightseeing], Groupings),
    \+ member([_, gym, maine, _], Groupings),

%Clue Five
    %Gross_activity != camping
    %woman_activity = antiquing

    %member([gross, _, _, _], Groupings), \+ member([_, _, _, camping], Groupings),

    \+ member([gross, _, _, camping], Groupings),
    (   member([gross, _, _, antiquing], Groupings) ;
        member([appleton, _, _, antiquing], Groupings) ;
        member([parnell, _, _, antiquing], groupings) ),

    tell(appleton, Appleton_subject, Appleton_state, Appleton_activity),
    tell(gross, Gross_subject, Gross_state, Gross_activity),
    tell(knight, Knight_subject, Knight_state, Knight_activity),
    tell(mcevoy, Mcevoy_subject, Mcevoy_state, Mcevoy_activity),
    tell(parnell, Parnell_subject, Parnell_state, Parnell_activity).

all_different([H | T]) :- member(H,T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(N, SUB, ST, A) :-
    write(N), write(' who teaches '),
    write(SUB), write(' is vacationing to '),
    write(ST), write(' and their activity is '),
    write(A), nl.
