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
#include "common/mmo.h"

#include "packets/basic.h"

class CCharEntity;

namespace dboxutils
{
    void HandlePacket(CCharEntity* PChar, CBasicPacket& data);

    void SendOldItems(CCharEntity* PChar, uint8 action, uint8 boxtype);
    void AddItemsToBeSent(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID, uint8 invslot, uint32 quantity, const std::string& recieverName);
    void SendConfirmation(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID);
    void CancelSendingItem(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID);
    void SendClientNewItemCount(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID);
    void SendNewItems(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID);
    void RemoveDeliveredItemFromSendingBox(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID);
    void UpdateDeliveryCellBeforeRemoving(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID);
    void ReturnToSender(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID);
    void TakeItemFromCell(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID);
    void RemoveItemFromCell(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID);
    void ConfirmNameBeforeSending(CCharEntity* PChar, uint8 action, uint8 boxtype, const std::string& receiver);
    void CloseMailWindow(CCharEntity* PChar, uint8 action, uint8 boxtype);

    void OpenSendBox(CCharEntity* PChar, uint8 action, uint8 boxtype);
    void OpenRecvBox(CCharEntity* PChar, uint8 action, uint8 boxtype);

    bool IsSendBoxOpen(CCharEntity* PChar);
    bool IsRecvBoxOpen(CCharEntity* PChar);
    bool IsAnyDeliveryBoxOpen(CCharEntity* PChar);

}; // namespace dboxutils
