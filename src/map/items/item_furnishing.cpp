/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "item_furnishing.h"

#include "exdata/base.h"
#include "exdata/furniture.h"
#include "exdata/mannequin.h"

CItemFurnishing::CItemFurnishing(uint16 id)
: CItem(id)
, m_storage(0)
, m_moghancement(0)
, m_element(0)
, m_aura(0)
, size_{ 1, 1 }
, height_(0)
, placement_(FurnishingPlacement::Floor)
{
    setType(ITEM_FURNISHING);
}

CItemFurnishing::CItemFurnishing(const CItemFurnishing& other) = default;

CItemFurnishing::~CItemFurnishing() = default;

void CItemFurnishing::setInstalled(bool installed)
{
    this->exdata<Exdata::Furniture>().Installed = installed ? 1 : 0;
}

auto CItemFurnishing::isInstalled() const -> bool
{
    return this->exdata<Exdata::Furniture>().Installed;
}

void CItemFurnishing::setStorage(uint8 storage)
{
    m_storage = std::min<uint8>(storage, 80);
}

auto CItemFurnishing::getStorage() const -> uint8
{
    return m_storage;
}

void CItemFurnishing::setMoghancement(uint16 moghancement)
{
    m_moghancement = moghancement;
}

auto CItemFurnishing::getMoghancement() const -> uint16
{
    return m_moghancement;
}

void CItemFurnishing::setElement(uint8 element)
{
    m_element = element;
}

auto CItemFurnishing::getElement() const -> uint8
{
    return m_element;
}

void CItemFurnishing::setAura(uint8 aura)
{
    m_aura = aura;
}

auto CItemFurnishing::getAura() const -> uint8
{
    return m_aura;
}

void CItemFurnishing::setSize(uint8 size_x, uint8 size_y)
{
    size_ = { size_x, size_y };
}

auto CItemFurnishing::size() const -> std::pair<uint8, uint8>
{
    return size_;
}

void CItemFurnishing::setHeight(uint16 height)
{
    height_ = height;
}

auto CItemFurnishing::height() const -> uint16
{
    return height_;
}

void CItemFurnishing::setPlacement(FurnishingPlacement placement)
{
    placement_ = placement;
}

auto CItemFurnishing::placement() const -> FurnishingPlacement
{
    return placement_;
}

void CItemFurnishing::setCol(uint8 col)
{
    this->exdata<Exdata::Furniture>().X = col;
}

auto CItemFurnishing::getCol() -> uint8
{
    return this->exdata<Exdata::Furniture>().X;
}

void CItemFurnishing::setRow(uint8 row)
{
    this->exdata<Exdata::Furniture>().Y = row;
}

auto CItemFurnishing::getRow() -> uint8
{
    return this->exdata<Exdata::Furniture>().Y;
}

void CItemFurnishing::setLevel(uint8 level)
{
    this->exdata<Exdata::Furniture>().Z = level;
}

auto CItemFurnishing::getLevel() -> uint8
{
    return this->exdata<Exdata::Furniture>().Z;
}

void CItemFurnishing::setRotation(uint8 rotation)
{
    this->exdata<Exdata::Furniture>().Rotation = rotation;
}

auto CItemFurnishing::getRotation() -> uint8
{
    return this->exdata<Exdata::Furniture>().Rotation;
}

void CItemFurnishing::setMannequinRace(uint8 race)
{
    this->exdata<Exdata::Mannequin>().Race = race;
}

auto CItemFurnishing::getMannequinRace() -> uint8
{
    return this->exdata<Exdata::Mannequin>().Race;
}

void CItemFurnishing::setMannequinPose(uint8 pose)
{
    this->exdata<Exdata::Mannequin>().Pose = pose;
}

auto CItemFurnishing::getMannequinPose() -> uint8
{
    return this->exdata<Exdata::Mannequin>().Pose;
}

void CItemFurnishing::setOn2ndFloor(bool on2ndFloor)
{
    this->exdata<Exdata::Furniture>().On2ndFloor = on2ndFloor ? 1 : 0;
}

auto CItemFurnishing::getOn2ndFloor() -> bool
{
    return this->exdata<Exdata::Furniture>().On2ndFloor;
}

auto CItemFurnishing::getSignature() const -> std::string
{
    return Exdata::decodeSignature(this->exdata<Exdata::Furniture>().Signature);
}

void CItemFurnishing::setSignature(const std::string& signature)
{
    Exdata::encodeSignature(signature, this->exdata<Exdata::Furniture>().Signature);
}

auto CItemFurnishing::isGardeningPot() const -> bool
{
    return this->isType(ITEM_FLOWERPOT);
}
