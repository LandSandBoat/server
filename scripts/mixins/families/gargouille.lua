-----------------------------------
-- Gargouille family mixin
-----------------------------------
require("scripts/globals/mixins")
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- This mobs switches between standing and flying at regular intervals (every 3-4 mins)
-- While standing, they use Terror Eye, Triumphant Roar and Bloody Claw
-- While flying, they use Dark Mist and Dark Orb, and they receive Evasion +60 and Magic Dmg Taken -12.5%.
-- Some Gargouille NMs can also use Shadow Burst

local function changeStance(mob)
    -- If mob is standing
    if mob:getAnimationSub() == 4 then
        mob:setAnimationSub(5) -- Fly
        mob:setMobMod(xi.mobMod.SKILL_LIST, 117) -- Set Fly Skill List. ("Dark Mist" and "Dark Orb")
        mob:addMod(xi.mod.EVA, 60)
        mob:addMod(xi.mod.DMGMAGIC, -1250)

    -- If mob is flying
    else
        mob:setAnimationSub(4) -- Stand
        mob:setMobMod(xi.mobMod.SKILL_LIST, 118) -- Set Standing Skill List. ("Terror Eye", "Triumphant Roar" and "Bloody Claw")
        mob:delMod(xi.mod.EVA, 60)
        mob:delMod(xi.mod.DMGMAGIC, -1250)
    end

    -- Reset timer
    mob:setLocalVar("formTimer", os.time() + math.random(180, 240))
end

g_mixins.families.gargouille = function(gargouilleMob)
    -- Set default state.
    gargouilleMob:addListener("SPAWN", "GARGOUILLE_SPAWN", function(mob)
        mob:setAnimationSub(4)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 118) -- Set Standing Skill List. ("Terror Eye", "Triumphant Roar" and "Bloody Claw")
        mob:setLocalVar("formTimer", os.time() + math.random(180, 240))
    end)

    -- Handle regular changes on roam.
    gargouilleMob:addListener("ROAM_TICK", "GARGOUILLE_ROAM", function(mob)
        if os.time() - mob:getLocalVar("formTimer") >= 0 then
            changeStance(mob)
        end
    end)

    -- Handle swapping stances in combat
    gargouilleMob:addListener("COMBAT_TICK", "GARGOUILLE_COMBAT", function(mob)
        if os.time() - mob:getLocalVar("formTimer") >= 0 then
            changeStance(mob)
        end
    end)
end

return g_mixins.families.gargouille
