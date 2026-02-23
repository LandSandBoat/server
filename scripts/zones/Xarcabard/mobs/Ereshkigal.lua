-----------------------------------
-- Area: Xarcabard
--   NM: Ereshkigal
-- Note: Works very similarly to Noble Mold spawn conditions
--       https://www.bg-wiki.com/ffxi/Ereshkigal
--       https://wiki.ffo.jp/html/12722.html
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    -- TODO - BRD immunities need confirmation.
    -- TODO any dmg absorb like Noble Mold?
    -- Confirmed it takes dmg from blizzard and water
    mob:addImmunity(xi.immunity.PARALYZE)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 100,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.DARK,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- set PH back to active spawn
    local ph = GetMobByID(mob:getID() - 1)
    if ph then
        DisallowRespawn(ph:getID(), false)
        ph:setRespawnTime(GetMobRespawnTime(ph:getID()))
    end
end

return entity
