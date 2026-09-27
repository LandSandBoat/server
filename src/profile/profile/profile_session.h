/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "enums/prof_error.h"
#include "enums/prof_request.h"
#include "profile/answer.h"
#include "profile/context.h"
#include "stream.h"

#include "common/cbasetypes.h"
#include "common/macros.h"
#include "common/scheduler.h"
#include "common/types/maybe.h"

#include <string>
#include <vector>

namespace profile
{

class PresenceManager;

// one profile connection, one request
class ProfileSession final
{
public:
    ProfileSession(Stream& stream, std::string peer, uint32 accountId, PresenceManager& presence);
    ~ProfileSession() = default;

    DISALLOW_COPY_AND_MOVE(ProfileSession);

    auto run() -> Task<void>;

private:
    auto handle(ProfRequest request) -> Maybe<ProfileAnswer>; // nullopt closes the connection
    auto unimplemented(ProfRequest request, ProfError error) -> ProfileAnswer;
    auto read(std::size_t size) -> Task<Maybe<std::vector<uint8>>>;
    auto write(const auto& buffers) -> Task<bool>;

    Stream& stream_;
    Context context_;
    uint32  sessionValue_;
};

auto runProfileSession(Stream stream, std::string peer, uint32 accountId, PresenceManager& presence) -> Task<void>;

} // namespace profile
