-----------------------------------
-- Area: Abyssea - Konschtat (15)
--   NM: Turul
-----------------------------------
mixins = {require("scripts/mixins/families/amphiptere")}
require("scripts/globals/status")
-----------------------------------

function onMobFight(mob, target)
    -- Uncertain of threshold. Going with 50% for now.
    -- (possibly varies, perhaps is simply lower HP = greater cast chance?)
    if mob:getHPP() <= 50 then
        mob:setMobMod(tpz.mobMod.SPELL_LIST, 175)
    else
        -- I'm assuming that if it heals up, it goes back to the other spell list.
        mob:setMobMod(tpz.mobMod.SPELL_LIST, 174)
        -- This 'else' can be removed if that isn't the case, and a localVar added so it only execs once.
    end
end

function onSpellPrecast(mob, spell)
    --[[
    Todo:
    "Turul will often cast Thunder based spells on itself to recover HP."
    One way of handling this would be treating ele nuke heals like we do melee special (use its own list)
    and setting absorb element 100% chance. This would let us use the AI's already existing "heal chance"
    ]]
end

function onMobDeath(mob, player, isKiller)
end
