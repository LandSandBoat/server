/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "packets/basic.h"

enum class GP_CLI_COMMAND_PBX_BOXNO : int8_t;
class CCharEntity;

namespace dboxutils
{

void SendOldItems(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo);
void AddItemsToBeSent(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo, int8_t ItemWorkNo, uint32 ItemStacks, const std::string& receiverName);
void SendConfirmation(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo);
void CancelSendingItem(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo);
void SendClientNewItemCount(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo);
void SendNewItems(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo);
void RemoveDeliveredItemFromSendingBox(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo);
void UpdateDeliveryCellBeforeRemoving(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo);
void ReturnToSender(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo);
void TakeItemFromCell(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo);
void RemoveItemFromCell(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo);
void ConfirmNameBeforeSending(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, const std::string& receiver);
void CloseMailWindow(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo);

void OpenSendBox(CCharEntity* PChar);
void OpenRecvBox(CCharEntity* PChar);

auto IsSendBoxOpen(const CCharEntity* PChar) -> bool;
auto IsRecvBoxOpen(const CCharEntity* PChar) -> bool;
auto IsAnyDeliveryBoxOpen(CCharEntity* PChar) -> bool;

}; // namespace dboxutils
