-----------------------------------
-- Area: Jugner Forest
-- NM: Cernunnos
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:setLocalVar('cernunnosDefeated', 1)
end

entity.onMobMobskillChoose = function(mob, target)
    local tpMoves =
    {
        xi.mobSkill.DRILL_BRANCH_NM,
        xi.mobSkill.PINECONE_BOMB_NM,
        xi.mobSkill.LEAFSTORM_DISPEL,
        xi.mobSkill.ENTANGLE_DRAIN,
    }

    return tpMoves[math.random(1, #tpMoves)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.STONE_IV,
        xi.magic.spell.STONEGA_III,
        xi.magic.spell.BREAK,
    }

    if not mob:hasStatusEffect(xi.effect.STONESKIN) then
        table.insert(spellList, 1, xi.magic.spell.STONESKIN)
    end

    if not mob:hasStatusEffect(xi.effect.PROTECT) then
        table.insert(spellList, xi.magic.spell.PROTECT_IV)
    end

    if not mob:hasStatusEffect(xi.effect.SHELL) then
        table.insert(spellList, xi.magic.spell.SHELL_IV)
    end

    if mob:getHPP() <= 30 then
        table.insert(spellList, xi.magic.spell.CURE_IV)
    end

    return spellList[math.random(1, #spellList)]
end

return entity
