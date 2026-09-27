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

#include "common/cbasetypes.h"

namespace profile
{

enum class ProfRequest : uint16
{
    StoreHandleNameList = 0x0008, // PS2: __sqPlayOnlineStoreHandleNameListCheck
    LoadHandleNameList  = 0x0009, // PS2: __sqPlayOnlineLoadHandleNameListCheck (PS2 0/7)
    LoadCharacterList   = 0x0103, // PS2: __sqPlayOnlineLoadCharacterListCheck
    StoreCharacterList  = 0x010A, // PS2: __sqPlayOnlineStoreCharacterListCheck
    SearchPolId         = 0x010B, // PS2: sqPlayOnlineSearchPolIdCheck2
    LoadFriendList      = 0x0203, // PS2: __sqPlayOnlineLoadFriendListCheck
    StoreFriendList     = 0x0206, // PS2: __sqPlayOnlineStoreFriendListCheck
    ReadFile            = 0x0300, // PS2: __sqProfReadFileCheck
    WriteFile           = 0x0301, // PS2: __sqProfWriteFileCheck
    RemoveFile          = 0x0302, // PS2: __sqProfDeleteFileCheck
    GetFileList         = 0x0303, // PS2: __sqProfGetFileListCheck
    WriteFileMulti      = 0x0304, // PS2: __sqProfWriteFileMultiCheck
    SetHandleComment    = 0x0403, // PS2: (New; did not exist.)
    ChangeMyStatus      = 0x0405, // PS2: sqPlayOnlineChangeMyStatusCheck (PS2 4/0)
    LoadMyStatus        = 0x0406, // PS2: sqPlayOnlineLoadMyStatusCheck (PS2 4/1)
    SecurityToken       = 0x0407, // PS2: (New; did not exist.)
    PolbesUpdateRecord  = 0x0501, // PS2: sqPolbesUpdateRecord
    PolbesSearchDataAll = 0x0503, // PS2: sqPolbesSearchDataAll
    PolbesSearchData    = 0x0504, // PS2: sqPolbesSearchData
    CreateGroup         = 0x0701, // PS2: (New; did not exist.)
    DeleteGroup         = 0x0702, // PS2: (New; did not exist.)
    ChangeGroupMember   = 0x0703, // PS2: (New; did not exist.)
    UpdateMyGroupEntry  = 0x070B, // PS2: (New; did not exist.)
    LoadGroupList       = 0x070C, // PS2: (New; did not exist.)
};

} // namespace profile
