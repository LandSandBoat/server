-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Aw'euvhi
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobSpawn(mob)
    -- Set a random animation when it spawns
    mob:AnimationSub(math.random(1, 4))
end

function onMobFight(mob)
    -- Forms: 0 = Closed  1 = Closed  2 = Open 3 = Closed
    -- According to http://wiki.ffxiclopedia.org/wiki/Category:Euvhi
    -- ..when attacked will change states every minute or so..
    local randomTime = math.random(50, 75)
    local changeTime = mob:getLocalVar("changeTime")

    if (mob:getBattleTime() - changeTime > randomTime) then
        if (mob:AnimationSub() == 2) then
            mob:AnimationSub(1)
        else
            mob:AnimationSub(2)
        end
        mob:setLocalVar("changeTime", mob:getBattleTime())

        -- According to http://wiki.ffxiclopedia.org/wiki/Category:Euvhi
        -- When in an open state, damage taken by the Euvhi is doubled. Inflicting a large amount of damage to an Euvhi in an open state will cause it to close.
        -- Make everything do double
        if (mob:AnimationSub() == 2) then
            mob:setMod(tpz.mod.HTHRES, 2000)
            mob:setMod(tpz.mod.SLASHRES, 2000)
            mob:setMod(tpz.mod.PIERCERES, 2000)
            mob:setMod(tpz.mod.IMPACTRES, 2000)
            for n =1, #tpz.magic.resistMod, 1 do
                mob:setMod(tpz.magic.resistMod[n], 2000)
            end
            for n =1, #tpz.magic.defenseMod, 1 do
                mob:setMod(tpz.magic.defenseMod[n], -1000)
            end
        else -- Reset all damage types
            mob:setMod(tpz.mod.HTHRES, 1000)
            mob:setMod(tpz.mod.SLASHRES, 1000)
            mob:setMod(tpz.mod.PIERCERES, 1000)
            mob:setMod(tpz.mod.IMPACTRES, 1000)
            for n =1, #tpz.magic.resistMod, 1 do
                mob:setMod(tpz.magic.resistMod[n], 1000)
            end
            for n =1, #tpz.magic.defenseMod, 1 do
                mob:setMod(tpz.magic.defenseMod[n], 1000)
            end
        end
    end
end

function onCriticalHit(target)
    -- According to http://wiki.ffxiclopedia.org/wiki/Category:Euvhi
    -- When in an open state, damage taken by the Euvhi is doubled. Inflicting a large amount of damage to an Euvhi in an open state will cause it to close.
    -- Crit is really the only thing we can do.
    if (target:AnimationSub() == 2) then
        target:AnimationSub(0)
    end
end

function onMobDeath(mob, player, isKiller)
end
