-----------------------------------
-- Lost Chick
-----------------------------------
-- Hantileon : !pos -2.675 -0.100 -105.287 230
-- Zopago    : !pos 51.706 0.874 -109.065 234
-- Pulonono  : !pos 130.124 -6.350 -119.341 241
-- Owners    : xi.chocoboRaising.walks.chickOwners
-----------------------------------
-- A chick's short walk finds a lost chick, trainers met on later walks give clues to its owner, and
-- the stable clerk reviews them. The right owner teaches the diligent story; any guess ends the
-- search, and the trainer reports how it went. State: xi.chocoboRaising.walks.lostChickVar.
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/constants')
require('scripts/globals/hobbies/chocobo_raising/walks')
-----------------------------------

local quest = HiddenQuest:new('LostChick')
local walks = xi.chocoboRaising.walks

local function ownerUpdate(location, ownerId, owner)
    return function(player, csid, option, npc)
        if not npc or npc:getName() ~= owner.npc then
            return
        end

        local choice = bit.band(option, 0xFFFF)

        -- Inline events offer the question only when p1 is 1.
        if choice == owner.ask then
            quest:setLocalVar(player, 'Asked', 1)
            player:updateEvent(1, 1, 1)
        elseif choice == owner.guess then
            -- An inline event's own options share the guess value, so only the one after the ask counts.
            if owner.ask then
                if quest:getLocalVar(player, 'Asked') == 0 then
                    return
                end

                quest:setLocalVar(player, 'Asked', 0)
            end

            local right, effects = walks.askOwner(player:getCharVar(walks.lostChickVar), location, ownerId)
            local answer         = right and 1 or 0

            -- Each owner event reads the answer from a different param, so it goes in p0 to p2.
            player:updateEvent(answer, answer, answer)
            xi.chocoboRaising.applyEffects(player, effects)

            if right then
                player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, xi.keyItem.STORY_OF_A_DILIGENT_CHOCOBO)
            end
        elseif owner.mapVendorEvent then
            xi.maps.onEventUpdate(player, owner.mapVendorEvent, option, npc)
        end
    end
end

-- Owners without an ask option play their question event on trigger.
local function ownerZone(location)
    local zone = { onEventUpdate = {} }

    for ownerId, owner in pairs(walks.chickOwners[location]) do
        if not owner.ask then
            zone[owner.npc] = quest:event(owner.events[1], 1)
        end

        for _, csid in ipairs(owner.events) do
            zone.onEventUpdate[csid] = ownerUpdate(location, ownerId, owner)
        end
    end

    return zone
end

-- The trainer's closing scene. p0 picks the line: 0 the owner came for the chick, 1 the trainer took it back.
local function reportEvent(player, csid, location)
    local returned = walks.lostChick(player:getCharVar(walks.lostChickVar)).result == walks.lostChickResult.RETURNED and 1 or 0

    return quest:progressEvent(csid, { [0] = 1 - returned, [1] = returned, [7] = location })
end

local function chickAt(player, location)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        return false
    end

    local chick = walks.lostChick(player:getCharVar(walks.lostChickVar))

    return chick.owner ~= 0 and chick.location == location
end

quest.sections =
{
    -- Step 1: Ask the San d'Oria owners about the lost chick. The right one teaches the diligent story.
    {
        check = function(player, questVars, vars)
            return chickAt(player, 1)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] = ownerZone(1),
    },

    -- Step 1: Ask the Bastok owners about the lost chick.
    {
        check = function(player, questVars, vars)
            return chickAt(player, 2)
        end,

        [xi.zone.BASTOK_MINES] = ownerZone(2),
    },

    -- Step 1: Ask the Windurst owners about the lost chick.
    {
        check = function(player, questVars, vars)
            return chickAt(player, 3)
        end,

        [xi.zone.WINDURST_WOODS] = ownerZone(3),
    },

    -- Step 2: The trainer reports how the search went and clears the result.
    {
        check = function(player, questVars, vars)
            return xi.settings.main.ENABLE_CHOCOBO_RAISING and
                walks.lostChick(player:getCharVar(walks.lostChickVar)).result ~= walks.lostChickResult.NONE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hantileon'] =
            {
                onTrigger = function(player, npc)
                    return reportEvent(player, 852, 1)
                end,
            },

            onEventFinish =
            {
                [852] = function(player, csid, option, npc)
                    xi.chocoboRaising.applyEffects(player, walks.clearLostChickResult(player:getCharVar(walks.lostChickVar)))
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Zopago'] =
            {
                onTrigger = function(player, npc)
                    return reportEvent(player, 542, 2)
                end,
            },

            onEventFinish =
            {
                [542] = function(player, csid, option, npc)
                    xi.chocoboRaising.applyEffects(player, walks.clearLostChickResult(player:getCharVar(walks.lostChickVar)))
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Pulonono'] =
            {
                onTrigger = function(player, npc)
                    return reportEvent(player, 766, 3)
                end,
            },

            onEventFinish =
            {
                [766] = function(player, csid, option, npc)
                    xi.chocoboRaising.applyEffects(player, walks.clearLostChickResult(player:getCharVar(walks.lostChickVar)))
                end,
            },
        },
    },
}

return quest
