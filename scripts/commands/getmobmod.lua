---------------------------------------------------------------------------------------------------
-- func: getmobmod <modID>
-- desc: gets a mod by ID on the player or cursor target
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getmod <modID>")
end

function onTrigger(player, id)
    -- invert xi.mobMod table
    local modNameByNum = {}
    for k, v in pairs(xi.mobMod) do
        modNameByNum[v] = k
    end

    -- validate modID
    id = string.upper(id)
    local modId = tonumber(id)
    local modName

    if modId then
        if modNameByNum[modId] then
            modName = modNameByNum[modId]
        end
    elseif xi.mobMod[id] then
        modId = xi.mobMod[id]
        modName = id
    end

    if not modName or not modId then
        error(player, "Invalid modMobID.")
        return
    end

    -- validate target
    local effectTarget = player:getCursorTarget()
    if not effectTarget or not effectTarget:isMob() then
        error(player, "Current target is not a MOB, which can not have mob mods.")
        return
    end

    player:PrintToPlayer(string.format("%s's Mod %i (%s) is %i", effectTarget:getName(), modId, modName, effectTarget:getMobMod(modId)))
end
