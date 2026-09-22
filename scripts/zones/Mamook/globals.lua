-- Zone: Mamook (65)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------

local mamookGlobal = {}

local thiefKeyInfo =
{
    -- [key type] = { { level, success rate}, { level, success rate} } -- extendable once different tiers are discovered
    [xi.item.SET_OF_THIEFS_TOOLS] = { {  75, 20 }, {  65, 10 } }, -- Based on 120 trades at 65, 70, and 75
    [xi.item.LIVING_KEY         ] = { {  75, 20 }, {  65, 10 } }, -- ToDo: Get Captures for large sets. Current Data at lvl 75 - 3/9
    [xi.item.SKELETON_KEY       ] = { {  75, 20 }, {  65, 10 } }, -- ToDo: Get Captures for large sets. Current Data at lvl 75 - 5/8
}

-----------------------------------
-- Attempts to lockpick a door using a traded THF tool, handling
-- success-rate lookup, outcome roll, and messaging in one place.
-----------------------------------
local function tryLockpick(player, npc, trade)
    local thfKeyType = 0

    if npcUtil.tradeMatches(trade, { { xi.item.SKELETON_KEY, 1 } }) then
        thfKeyType = xi.item.SKELETON_KEY
    elseif npcUtil.tradeMatches(trade, { { xi.item.LIVING_KEY, 1 } }) then
        thfKeyType = xi.item.LIVING_KEY
    elseif npcUtil.tradeMatches(trade, { { xi.item.SET_OF_THIEFS_TOOLS, 1 } }) then
        thfKeyType = xi.item.SET_OF_THIEFS_TOOLS
    end

    -- not a valid thief lockpick tool
    if thfKeyType == 0 then
        return
    end

    -- find the success rate by player level
    local brackets = thiefKeyInfo[thfKeyType]
    local playerLevel = player:getMainLvl()
    local rate = 0

    for i = 1, #brackets do
        if playerLevel >= brackets[i][1] then
            rate = brackets[i][2]
            break
        end
    end

    -- determine and handle outcome
    if math.randomInt(1, 100) <= rate then
        npc:openDoor(15)
        player:showText(npc, bit.bor(ID.text.LOCK_SUCCESS, 0x8000), thfKeyType, 0, 15, 0, false, false)
    else
        player:showText(npc, bit.bor(ID.text.LOCK_FAIL, 0x8000), thfKeyType, 0, 15, 0, false, false)
    end

    player:tradeComplete()
end

-----------------------------------
-- Trading to attempt to open a locked Ebony Door
-- lockedSideOfDoor (boolean) true if player is trading from the locked side
-----------------------------------
mamookGlobal.onTradeEbonyDoor = function(player, npc, trade, lockedSideOfDoor)
    -- early exit criteria
    if
        trade:getItemCount() ~= 1 or
        npc:getAnimation() ~= xi.animation.CLOSE_DOOR or
        not lockedSideOfDoor
    then
        return
    end

    -- handle the Tanscale Key
    if npcUtil.tradeMatches(trade, { { xi.item.MAMOOK_TANSCALE_KEY, 1 } }) then
        npc:openDoor(15)
        player:showText(npc, bit.bor(ID.text.KEY_BREAKS, 0x8000), xi.item.MAMOOK_TANSCALE_KEY, 0, 14, 65344, false, false)
        player:tradeComplete()
        return
    end

    -- handle lockpicking
    if player:getMainJob() == xi.job.THF then
        tryLockpick(player, npc, trade)
    end
end

-----------------------------------
-- Player interacting with Ebony Door
-- lockedSideOfDoor (boolean) true if player is interacting from the locked side
-----------------------------------
mamookGlobal.onTriggerEbonyDoor = function(player, npc, lockedSideOfDoor)
    if npc:getAnimation() == xi.animation.CLOSE_DOOR then
        if lockedSideOfDoor then
            if player:getMainJob() == xi.job.THF then
                player:showText(npc, bit.bor(ID.text.DOOR_IS_LOCKED2, 0x8000), xi.item.MAMOOK_TANSCALE_KEY, xi.item.SET_OF_THIEFS_TOOLS, 15, 0, false, false)
            else
                player:showText(npc, bit.bor(ID.text.DOOR_IS_LOCKED, 0x8000), xi.item.MAMOOK_TANSCALE_KEY, 0, 14, 65344, false, false)
            end
        else
            player:messageText(npc, ID.text.YOU_UNLOCK_DOOR, false, 6)
            npc:openDoor(15)
        end
    end
end

return mamookGlobal
