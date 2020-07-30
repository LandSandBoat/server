---------------------------------------------------------------------------------------------------
-- func: getmod <modID>
-- desc: gets a mod by ID on the player or cursor target
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 3,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getmod <modID>")
end

function onTrigger(player, id)
    -- invert tpz.mod table
    local modNameByNum = {}
    for k, v in pairs(tpz.mod) do
        modNameByNum[v]=k
    end

    -- validate modID
    id = string.upper(id)
    local modId = tonumber(id)
    local modName = nil

    if modId ~= nil then
        if modNameByNum[modId] ~= nil then
            modName = modNameByNum[modId]
        end
    elseif tpz.mod[id] ~= nil then
        modId = tpz.mod[id]
        modName = id
    end
    if modName == nil or modId == nil then
        error(player, "Invalid modID.")
        return
    end

    -- validate target
    local effectTarget = player:getCursorTarget()
    if effectTarget == nil then
        effectTarget = player
    elseif effectTarget:isNPC() then
        error(player, "Current target is an NPC, which can not have mods.")
        return
    end

    player:PrintToPlayer(string.format("%s's Mod %i (%s) is %i", effectTarget:getName(), modId, modName, effectTarget:getMod(modId)))
end
