-----------------------------------
-- Zeni NM System + Helpers
-- Soultrapper                 : !additem 18721
-- Blank Soul Plate            : !additem 18722
-- Soultrapper 2000            : !additem 18724
-- Blank High-Speed Soul Plate : !additem 18725
-- Used Soul Plate             : !additem 2477
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/common")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/pankration")
require("scripts/globals/utils")
-----------------------------------

xi = xi or {}
xi.znm = xi.znm or {}

xi.znm.soultrapperOnItemCheck = function(target, user)
    if not user:isFacing(target) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    local id = user:getEquipID(xi.slot.AMMO)
    if
        id ~= xi.items.BLANK_SOUL_PLATE and
        id ~= xi.items.BLANK_HIGH_SPEED_SOUL_PLATE
    then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if user:getFreeSlotsCount() == 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

xi.znm.soultrapperOnItemUse = function(target, user)
    local name = target:getName()
    local hpp = target:getHPP()
    local system = target:getSystem()
    local isNM = target:isNM()
    local distance = user:checkDistance(target)
    local isFacing = target:isFacing(user)

    -- Determine Zeni value
    local zeni = 5

    -- HP% Component: x1 at 100%, x10 at 1%
    zeni = zeni * math.min(100 / hpp, 10)

    -- In-Demand System Component
    -- TODO: Make rotating server var
    local inDemandSystem = 10 -- Dragons
    if system == inDemandSystem then
        zeni = zeni * 1.5
    end

    -- NM/Rarity Component
    if isNM then
        zeni = zeni * 1.5
    end

    -- Distance Component
    zeni = zeni * math.max((1 / distance) * 2, 1)

    -- Angle/Facing Component
    if isFacing then
        zeni = zeni * 1.5
    end

    -- TODO: Write Zeni value to soulplate
    utils.unused(zeni)

    -- Pick a skill totally at random...
    local skillIndex, skillEntry = utils.randomEntry(xi.pankration.feralSkills)

    -- Add plate
    local plate = user:addSoulPlate(name, skillIndex, skillEntry.fp)
    local data = plate:getSoulPlateData()
    utils.unused(data)
end
