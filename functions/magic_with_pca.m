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
## @deftypefn {} {@var{retval} =} magic_with_pca (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2021-09-08

function [train, miu, Y, Vk] = magic_with_pca (train_mat, pcs)
  [m, n] = size (train_mat);

  % initializare train
  train = zeros (m, n);

  % initializare miu
  miu = zeros (1, n);

  % initializare Y
  Y = zeros (m, pcs);

  % initializare Vk
  Vk = zeros (n, pcs);

  % cast train_mat la double.
  X = cast(train_mat, "double");

  % calculeaza media fiecarei coloane a matricei.
  miu = mean(X);

  % scade media din matricea initiala.
  X = X - miu;

  % calculeaza matricea de covarianta.
  cov_matrix = X' * X / (m - 1);

  % calculeaza vectorii si valorile proprii ale matricei de covarianta.
  [V S] = eig(cov_matrix);

  % ordoneaza descrescator valorile proprii si creaza o matrice V
  % formata din vectorii proprii asezati pe coloane, astfel incat prima coloana
  % sa fie vectorul propriu corespunzator celei mai mari valori proprii si
  % asa mai departe.

  % pun valorile proprii intr-un vector pe care il sorzez descrescator
  % functia sort intorce vectorul sortat si un vector cu vechile pozitii ale elementelor
  val_proprii = diag(S);
  [val_proprii, indices] = sort(val_proprii, "descend");
  S = diag(val_proprii);            %ordonez si matricea diagonala a valorile proprii
  V = V(:, indices);                %odonez vectorii proprii pentru a se potrivi cu valorile proprii

  % pastreaza doar primele pcs coloane din matricea obtinuta anterior.
  Vk = V(:, 1 : pcs);

  % creaza matricea Y schimband baza matricei initiale.
  Y = X * Vk;

  % calculeaza matricea train care este o aproximatie a matricei initiale
  % folosind matricea Vk calculata anterior
  train = Y * Vk';

endfunction
