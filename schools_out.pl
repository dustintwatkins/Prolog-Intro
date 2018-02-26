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


solve:-
  subject(appleton_subject),
  subject(gross_subject),
  subject(knight_subject),
  subject(mcEvoy_subject),
  subject(parnell_subject),
  all_different([appleton_subject, gross_subject, knight_subject, mcEvoy_subject, parnell_subject]),

  state(appleton_state),
  state(gross_state),
  state(knight_state),
  state(mcEvoy_state),
  state(parnell_state),
  all_different([appleton_state, gross_state, knight_state, mcEvoy_state, parnell_state]),

  activity(appleton_activity),
  activity(gross_activity),
  activity(knight_activity),
  activity(mcEvoy_activity),
  activity(parnell_activity),
  all_different([appleton_activity, gross_activity, knight_activity, mcEvoy_activity, parnell_activity]),

  groupings = [ [appleton, appleton_subject, appleton_state, appleton_activity],
            [gross, gross_subject, gross_state, gross_activity],
            [knight, knight_subject, knight_state, knight_activity],
            [mcEvoy, mcEvoy_subject, mcEvoy_state, mcEvoy_activity],
            [parnell, parnell_subject, parnell_state, parnell_activity] ],


%Clue One
    %gross_subject = math || gross_subject = science
    %if gross_activity = antiquing -> gross_state = florida
      %else gross_state = california

    %member(name, subject, state, activity)

    ( member([gross, math, _, _], groupings) ;
    member([gross, science, _, _], groupings) ),

    ( member([gross, _, florida, antiquing], groupings) ;
    member([gross, _, california, _], groupings) ),


%Clue Two
    %person_subject = science && person_activity = water_skiing
      %person_state = florida || person_state = california
    %mcEvoy_subject = history && mcEvoy_state = maine || mcEvoy_state = oregon

    ( member([_, science, florida, water_skiing], groupings) ;
    member([_, science, california, water_skiing], groupings) ),

    ( member([mcEvoy, history, maine, _], groupings) ;
    member([mcEvoy, history, oregon, _], groupings) ),


%Clue Three
    %(appleton_state = virginia && appleton_subject = english) || parnell_state = virginia
    %parnell_activity = spelunking

    ( member ([appleton, english, virginia, _], groupings) ; member ([parnell, _, virginia, _,], groupings) ),
    member ([parnell, _, _, spelunking], groupings),

%Clue Four
    %person_state = maine && person_subject != gym && person_activity != sightseeing

    \+ member ([_, _, maine, sightseeing], groupings),
    \+ member ([_, gym, main, _], groupings),

%Clue Five
    %gross_activity != camping
    %woman_activity = antiquing

    %member ([gross, _, _, _], groupings), \+ member ([_, _, _, camping], groupings),
    \+ member ([gross, _, _, camping], groupings),
    (   member ([gross, _, _, antiquing], groupings) ;
        member ([appleton, _, _, antiquing], groupings) ;
        member ([parnell, _, _, antiquing], groupings) ),

    tell(appleton, appleton_subject, appleton_state, appleton_activity),
    tell(gross, gross_subject, gross_state, gross_activity),
    tell(knight, knight_subject, knight_state, knight_activity),
    tell(mcEvoy, mcEvoy_subject, mcEvoy_state, mcEvoy_activity),
    tell(parnell, parnell_subject, parnell_state, parnell_activity).

%Check Logic
all_different([H | T]) :- member(H,T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(N, SUB, ST, A) :-
    write(N), write(' who teaches '),
    write(SUB), write(' is vacationing to '),
    write(ST), write(' and their activity is'),
    write(A), nl.
