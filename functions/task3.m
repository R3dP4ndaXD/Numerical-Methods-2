## Copyright (C) 2021 Andrei
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} pca_cov (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2021-09-06

function new_X = task3 (photo, pcs)
  [m, n] = size (photo);

  % initializare matrice finala.
  new_X = zeros (m, n);

  % cast photo la double.
  A =  cast (photo, "double");

  % TODO: calculeaza media fiecarui rand al matricii.
                            % calculeaza media fiecarei linii facand
  miu = sum(A, 2)/n;        % suma pe fiecarei linie si dupa impartind la n

  % normalizeaza matricea initiala scazand din ea media fiecarui rand.
   A = A - miu;             % scade din fiecarea element de pe linia i a lui A valorea Miu(i)

  %calculeaza matricea de covarianta.
  Z = A * A'/ (n -1);

  %calculeaza vectorii si valorile proprii ale matricei de covarianta.
  [V S] = eig(Z);

  % ordoneaza descrescator valorile proprii si creaza o matrice V
  % formata din vectorii proprii asezati pe coloane, astfel incat prima coloana
  % sa fie vectorul propriu corespunzator celei mai mari valori proprii si
  % asa mai departe.

  % pun valorile proprii intr-un vector pe care il sorzez descrescator
  % functia sort intorce vectorul sortat si un vector cu vechile pozitii ale elementelor
  val_proprii = diag(S);
  [val_proprii, indices] = sort(val_proprii, "descend");

  S = diag(val_proprii);     % ordonez si matricea diagonala a valorile proprii
  V = V(:, indices);         % odonez vectorii proprii pentru a se potrivi cu valorile proprii


  % pastreaza doar primele pcs coloane
  % OBS: primele coloane din V reprezinta componentele principale si
  % pastrandu-le doar pe cele mai importante obtinem astfel o compresie buna
  % a datelor. Cu cat crestem numarul de componente principale claritatea
  % imaginii creste, dar de la un numar incolo diferenta nu poate fi sesizata
  % de ochiul uman asa ca pot fi eliminate.
  W = V(:, 1 : pcs);

  % creaza matricea Y schimband baza matricei initiale.
  Y = W' * A;

  % calculeaza matricea new_X care este o aproximatie a matricei initiale
  new_X = W * Y + miu;

  % aduna media randurilor scazuta anterior.
  A = A + miu;

  % transforma matricea in uint8 pentru a fi o imagine valida.
  new_X =  cast (new_X, "uint8");

endfunction
