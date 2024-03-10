## Copyright (C) 2023 Andrei
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
## @deftypefn {} {@var{retval} =} task2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2023-02-28

function new_X = task2 (photo, pcs)
  [m n] = size(photo);

  % initializare matrice finala
  new_X = zeros(m, n);

  % cast photo la double
  A =  cast (photo, "double");

  % normalizeaza matricea initiala scazand din ea media fiecarei linii.
  miu = sum(A, 2)/n;      %calculeaza media fiecarei linii facand
                          %suma pe fiecarei linie si dupa impartind la nr de coloane n
  A = A - miu;            %scade din fiecarea element de pe linie i a lui A valorea Miu(i)

  % construieste matricea Z
  Z = A' / sqrt(n - 1);

  % calculeaza matricile U, S si V prin aplicarea SVD pe matricea Z
  [U, S, V] = svd (Z);

  % construieste matricea W din primele pcs coloane ale lui V
  W = V(:, 1 : pcs);

  % cacluleaza matricea Y
  Y = W' * A;

  % aproximeaza matricea initiala
  new_X = W * Y + miu;

  %transforma matricea in uint8 pentru a fi o imagine valida.
  new_X =  cast (new_X, "uint8");
endfunction
