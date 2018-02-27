%Customer Facts
customer(hugh).
customer(ida).
customer(jeremy).
customer(leroy).
customer(stella).

%Item Facts
item(balloons).
item(candles).
item(chocolates).
item(place_cards).
item(streamers).

%Event Facts
event(anniversary).
event(charity_auction).
event(retirement).
event(senior_prom).
event(wedding).

%Rose facts
rose(cottage_beauty).
rose(golden_sunset).
rose(mountain_bloom).
rose(pink_paradise).
rose(sweet_dreams).

solve :-
  rose(Hugh_rose), rose(Ida_rose), rose(Jeremy_rose), rose(Leroy_rose), rose(Stella_rose),
  all_different([Hugh_rose, Ida_rose, Jeremy_rose, Leroy_rose, Stella_rose]),

  item(Hugh_item), item(Ida_item), item(Jeremy_item), item(Leroy_item), item(Stella_item),
  all_different([Hugh_item, Ida_item, Jeremy_item, Leroy_item, Stella_item]),

  event(Hugh_event), event(Ida_event), event(Jeremy_event), event(Leroy_event), event(Stella_event),
  all_different([Hugh_event, Ida_event, Jeremy_event, Leroy_event, Stella_event]),

  Groupings = [ [hugh, Hugh_rose, Hugh_item, Hugh_event],
            [ida, Ida_rose, Ida_item, Ida_event],
            [jeremy, Jeremy_rose, Jeremy_item, Jeremy_event],
            [leroy, Leroy_rose, Leroy_item, Leroy_event],
            [stella, Stella_rose, Stella_item, Stella_event] ],

% Clue One
  % Jeremy_event = senior_prom
  % Stella_event != wedding
  % Stella_rose = cottage_beauty

  %member(person, rose, item, event)

  member([jeremy, _, _, senior_prom], Groupings),
  member([stella, cottage_beauty, _, _], Groupings),

  %stella did not purchase for wedding
  \+ member([stella, _, _, wedding], Groupings),

%Clue Two
  %Hugh_rose = pink_paradise
  %Hugh_event != charity_auction
  %Hugh_event != wedding

  member([hugh, pink_paradise, _, _], Groupings),
  \+ member([hugh, _, _, charity_auction], Groupings),
  \+ member([hugh, _, _, wedding], Groupings),

%Clue Three
  %person_event = anniversary && person_item = streamers
  %person_event = wedding && person_item = balloons

  member([_, _, streamers, anniversary], Groupings),
  member([_, _, balloons, wedding], Groupings),

%Clue Four
  %person_rose = sweet_dreams && person_item = chocolates
  %Jeremy_rose != mountain_bloom

  member([_, sweet_dreams, chocolates, _], Groupings),
  \+ member([jeremy, mountain_bloom, _, _], Groupings),

%Clue Five
  %Leroy_event = retirement
  %person_event = senior_prom && person_item = candles

  member([leroy, _, _, retirement], Groupings),
  member([_, _, candles, senior_prom], Groupings),

  tell(hugh, Hugh_rose, Hugh_item, Hugh_event),
  tell(ida, Ida_rose, Ida_item, Ida_event),
  tell(jeremy, Jeremy_rose, Jeremy_item, Jeremy_event),
  tell(leroy, Leroy_rose, Leroy_item, Leroy_event),
  tell(stella, Stella_rose, Stella_item, Stella_event).

all_different([H | T]) :- member(H,T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(C, R, I, E) :-
  write(C), write(' bought the '),
  write(R), write(' rose and '),
  write(I), write(' for the '),
  write(E), write(' event.'), nl.
