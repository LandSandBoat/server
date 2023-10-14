-----------------------------------
-- Area: Halvung
--   NM: Big Bomb
-- Note: Big Bomb grows in size when it takes over 500 dmg in one blow
-- Reports in testimonials state that he is stronger on Firesday and
-- weaker on Watersday ***This requires verification***
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SLEEP)
    mob:addImmunity(xi.immunity.STUN)
    mob:setMod(xi.mod.SILENCERES, 75)
    mob:setAnimationSub(0)

    -- Unclear what happens to Big Bomb's stats or behavior when he increases in size.
    -- For now it is purely visual until further evidence produces itself
    mob:addListener("TAKE_DAMAGE", "TAKE_DAMAGE_BIG_BOMB", function(mobArg, amount, attacker, attackType, damageType)
        local anim = mobArg:getAnimationSub()
        if
            amount >= 500 and
            anim < 3
        then
            mobArg:setAnimationSub(anim + 1)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 466)
    mob:setAnimationSub(4) -- Shrinks down as he dies
end

return entity
