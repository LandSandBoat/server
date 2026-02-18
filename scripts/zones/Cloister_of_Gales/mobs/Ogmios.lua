-----------------------------------
-- Area: Cloister of Gales
--  Mob: Ogmios
-- Involved in Quest: Carbuncle Debacle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 300)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 4)
    mob:setMod(xi.mod.BIND_RES_RANK, 4)
    mob:setMod(xi.mod.ICE_RES_RANK, 4)
    mob:setMod(xi.mod.WIND_RES_RANK, 10)
    mob:setMod(xi.mod.STORETP, 25) -- 8 hit to 1k tp
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.SILENCEGA,
        xi.magic.spell.DISPELGA,
    }

    return spellList[math.random(1, #spellList)]
end

return entity
