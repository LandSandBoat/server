-----------------------------------
-- Furniture Quest - Armoire
-----------------------------------

local quest         = HiddenQuest:new('FurnitureQuest_Armoire')

quest.furniture     = xi.item.ARMOIRE
quest.reward        = xi.item.SCROLL_OF_PROTECT_IV
quest.waitTime      = 240
quest.rewardOption  = 5
quest.fameRequired  = 7

quest.sections    = {}
quest.sections[1] = {}

-----------------------------------
-- Quest reward gating occurs on Moogle interaction
-----------------------------------
quest.sections[1].check = function(player, questVars, vars)
    return xi.moghouse.inMogHouseInHomeNation(player) and
        player:getFameLevel(player:getNation()) >= quest.fameRequired and
        not quest:getMustZone(player) and
        questVars.RewardObtained == 0 and
        questVars.PlacedTime ~= 0 and
        questVars.PlacedTime + quest.waitTime < GetSystemTime()
end

local moogleTriggerEvent =
{
    ['Moogle'] =
    {
        onTrigger = function(player, npc)
            return quest:progressEvent(30003, 0, 0, quest.rewardOption, quest.furniture)
        end,
    },

    onEventFinish =
    {
        [30003] = function(player, csid, option, npc)
            if npcUtil.giveItem(player, quest.reward) then
                quest:setVar(player, 'RewardObtained', GetSystemTime())
                quest:setVar(player, 'PlacedTime', 0)
            end
        end,
    },
}

for _, zoneId in ipairs(xi.moghouse.moghouseZones) do
    quest.sections[1][zoneId] = moogleTriggerEvent
end

-----------------------------------
-- Furniture placement
-----------------------------------
-- Placement only records a start time while the reward hasn't been claimed yet
quest.sections[2] = {}

quest.sections[2].check = function(player, questVars, vars)
    return questVars.RewardObtained == 0
end

local armoirePlacedEvent =
{
    ['armoire'] =
    {
        onFurniturePlaced = function(player, item)
            quest:setVar(player, 'PlacedTime', GetSystemTime())
            quest:setMustZone(player)
        end,
    },
}

for _, zoneId in ipairs(xi.moghouse.moghouseZones) do
    quest.sections[2][zoneId] = armoirePlacedEvent
end

-----------------------------------
-- Furniture removal
-----------------------------------
-- Removal always clears PlacedTime, unconditionally
quest.sections[3] = {}

local armoireRemovedEvent =
{
    ['armoire'] =
    {
        onFurnitureRemoved = function(player, item)
            quest:setVar(player, 'PlacedTime', 0)
        end,
    },
}

for _, zoneId in ipairs(xi.moghouse.moghouseZones) do
    quest.sections[3][zoneId] = armoireRemovedEvent
end

return quest
