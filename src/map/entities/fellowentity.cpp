/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "fellowentity.h"

namespace
{
const std::map<CharRace, std::vector<std::string>> fellowNames = {
    { CharRace::HumeMale, { "Feliz", "Ferdinand", "Gunnar", "Massimo", "Oldrich", "Siegward", "Theobald", "Zenji" } },
    { CharRace::HumeFemale, { "Amerita", "Beatrice", "Henrietta", "Jesimae", "Karyn", "Nanako", "Sharlene", "Sieghilde" } },
    { CharRace::ElvaanMale, { "Chanandit", "Deulmaeux", "Demresinaux", "Ephealgaux", "Gauldeval", "Grauffemart", "Migaifongut", "Romidiant" } },
    { CharRace::ElvaanFemale, { "Armittie", "Cadepure", "Clearite", "Epilleve", "Liabelle", "Nauthima", "Radille", "Vimechue" } },
    { CharRace::TarutaruMale, { "Balu-Falu", "Burg-Ladarg", "Ehgo-Ryuhgo", "Kolui-Pelui", "Nokum-Akkum", "Savul-Kivul", "Vinja-Kanja", "Yarga-Umiga" } },
    { CharRace::TarutaruFemale, { "Cupapa", "Jajuju", "Kalokoko", "Mahoyaya", "Pakurara", "Ripokeke", "Yawawa", "Yufafa" } },
    { CharRace::Mithra, { "Fhig Lahrv", "Khuma Tagyawhan", "Pimy Kettihl", "Raka Maimhov", "Sahyu Banjyao", "Sufhi Uchnouma", "Tsuim Nhomango", "Yoli Kohlpaka" } },
    { CharRace::Galka, { "Durib", "Dzapiwa", "Jugowa", "Mugido", "Voldai", "Wagwei", "Zayag", "Zoldof" } },
};
}

CFellowEntity::CFellowEntity(CCharEntity* PChar)
: CMobEntity()
{
    objtype = TYPE_FELLOW;

    // TODO
}

CFellowEntity::~CFellowEntity()
{
    // TODO
}
