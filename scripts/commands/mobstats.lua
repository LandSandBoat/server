-----------------------------------
-- func: !mobstats
-- desc: Provides player with target stats
--(mob name [mob level] acc, eva, attack, def)
--(STR, DEX, VIT, AGI, INT, MND, CHR)
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local target = player:getCursorTarget()
    if target ~= nil and target:isMob() then
        local mob   = target:getName()
        local level = target:getMainLvl()
        local acc   = target:getACC()
        local eva   = target:getEVA()
        local atk   = target:getMod(xi.mod.ATT)
        local def   = target:getMod(xi.mod.DEF)
        local str   = target:getStat(xi.mod.STR)
        local dex   = target:getStat(xi.mod.DEX)
        local vit   = target:getStat(xi.mod.VIT)
        local agi   = target:getStat(xi.mod.AGI)
        local int   = target:getStat(xi.mod.INT)
        local mnd   = target:getStat(xi.mod.MND)
        local chr   = target:getStat(xi.mod.CHR)
        player:printToPlayer(string.format('%s [Level %i] - Accuracy: %i Evasion: %i Attack: %i Defense: %i', mob, level, acc, eva, atk, def))
        player:printToPlayer(string.format('STR: %i  DEX: %i  VIT: %i  AGI: %i  INT: %i  MND: %i  CHR: %i', str, dex, vit, agi, int, mnd, chr))
    else
        player:printToPlayer('You must select a valid target.')
    end
end

return commandObj
