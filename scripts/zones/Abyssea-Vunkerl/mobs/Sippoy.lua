-----------------------------------
-- Area: Abyssea - Vunkerl
--   NM: Sippoy
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobFight(mob, target)
    if mob:getHPP() < 50 then
        mob:setMobMod(tpz.mobMod.SPELL_LIST, 159)
    else
        -- I'm assuming that if it heals up, it goes back to the its original spell list.
        mob:setMobMod(tpz.mobMod.SPELL_LIST, 158)
        -- This 'else' can be removed if that isn't the case, and a localVar added so it only execs once.
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.SIPPOY_CAPTURER)
end
