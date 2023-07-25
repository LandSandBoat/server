/*
===========================================================================

Copyright (c) 2023 LandSandBoat Dev Teams

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

#pragma once
#include <cstdint>

namespace loginErrors
{
    enum errorCode : uint16_t
    {
        UNABLE_TO_CONNECT_TO_WORLD_SERVER = 305, // "Unable to connect to the world server. Specified operation failed."

        // TODO -- This message is displayed in Japanese, needs fixing.
        CHARACTER_NAME_UNAVAILABLE = 313, // "The character name you entered is unavailable.\nPlease choose another name."

        FAILED_TO_REGISTER_WITH_THE_NAME_SERVER = 314, // "Failed to register with the name server."
        CHARACTERS_PARAMETERS_ARE_INCORRECT     = 321, // "Character's parameters are incorrect."
        GAMES_DATA_HAS_BEEN_UPDATED             = 331, // "The games data has been updated."
        COULD_NOT_CONNECT_TO_LOBBY_SERVER       = 332, // "Could not connect to lobby server.\nPlease check this title's news for announcements."
    };
}
