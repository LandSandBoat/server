-----------------------------------
-- Wamouracampa family mixin
-----------------------------------
require("scripts/globals/mixins")
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- This mobs curl up based on damage taken.
-- If they take a hit higher than 5% oh their Max HP OR if they take a total of 1k (aprox) damage, they will curl.
-- If they are already curled, they will reset conditions and remain curled.
-- They will keep streched so long as none of the above conditions are met. Linked Wamouracampas will obviously stay streched.

local function curlUpRoaming(mob)
    mob:setAnimationSub(5) -- Curl
    mob:setLocalVar("formTimeRoam", os.time() + math.random(43, 47))
    mob:setMobMod(xi.mobMod.SKILL_LIST, 1162) -- Set Curled Skill List. ("Cannonball" and "Heat Barrier" only)
    mob:addMod(xi.mod.DMGPHYS, -2500)
    mob:delMod(xi.mod.DMGMAGIC, -2500)
end

local function strechUpRoaming(mob)
    mob:setAnimationSub(4) -- Strech
    mob:setLocalVar("formTimeRoam", os.time() + math.random(43, 47))
    mob:setMobMod(xi.mobMod.SKILL_LIST, 254) -- Set streched Skill List. (All TP moves except "Cannonball")
    mob:delMod(xi.mod.DMGPHYS, -2500)
    mob:addMod(xi.mod.DMGMAGIC, -2500)
end

local function curlUpEngaged(mob)
    mob:setAnimationSub(5) -- Curl
    mob:setMobMod(xi.mobMod.SKILL_LIST, 1162) -- Set Curled Skill List. ("Cannonball" and "Heat Barrier" only)
    mob:addMod(xi.mod.DMGPHYS, -2500)
    mob:delMod(xi.mod.DMGMAGIC, -2500)
end

local function strechUpEngaged(mob)
    mob:setAnimationSub(4) -- Strech
    mob:setMobMod(xi.mobMod.SKILL_LIST, 254) -- Set streched Skill List. (All TP moves except "Cannonball")
    mob:delMod(xi.mod.DMGPHYS, -2500)
    mob:addMod(xi.mod.DMGMAGIC, -2500)
end

local function resetCount(mob)
    mob:setLocalVar("formTimeEngaged", os.time() + math.random(40, 50))
    mob:setLocalVar("hitPoints",  mob:getHP() - math.floor(mob:getMaxHP() * 20 / 100))
end

g_mixins.families.wamouracampa = function(wamouracampaMob)
    -- Set spawn.
    wamouracampaMob:addListener("SPAWN", "WAMOURACAMPA_SPAWN", function(mob)
        mob:setAnimationSub(4)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 254)
        mob:addMod(xi.mod.DMGMAGIC, -2500)
        mob:setLocalVar("hitPoints", mob:getHP())
        mob:setLocalVar("formTimeRoam", os.time() + math.random(30, 90))
        mob:setLocalVar("formTimeEngaged", os.time())
    end)

    -- Handle regular changes on roam.
    wamouracampaMob:addListener("ROAM_TICK", "WAMOURACAMPA_ROAM", function(mob)
        if os.time() - mob:getLocalVar("formTimeRoam") > 0 then
            if mob:getAnimationSub() == 4 then
                curlUpRoaming(mob)
            elseif mob:getAnimationSub() == 5 then
                strechUpRoaming(mob)
            end
        end
    end)

    -- First damaging hit makes mob curl if not already.
    wamouracampaMob:addListener("ENGAGE", "WAMOURACAMPA_ENGAGE", function(mob)
        if
            mob:getLocalVar("hitPoints") < mob:getHP() and
            mob:getAnimationSub() == 4
        then
            curlUpEngaged(mob)
            resetCount(mob)
        end
    end)

    -- Handle streching from curl.
    wamouracampaMob:addListener("COMBAT_TICK", "WAMOURACAMPA_COMBAT", function(mob)
        if
            mob:getAnimationSub() == 5 and
            os.time() - mob:getLocalVar("formTimeEngaged") > 0 and -- IF safety timer is over
            os.time() - mob:getLocalVar("formTimeRoam") > 0 and    -- Additional check in case its already curled.
            mob:getLocalVar("hitPoints") < mob:getHP()
        then
            strechUpEngaged(mob)
            resetCount(mob)
        end
    end)

    -- Handle curling from being streched or remaining curled.
    wamouracampaMob:addListener("TAKE_DAMAGE", "WAMOURACAMPA_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if
            os.time() - mob:getLocalVar("formTimeEngaged") > 0 and
            (amount > math.floor(mob:getMaxHP() * 5 / 100) or
            mob:getLocalVar("hitPoints") > mob:getHP())
        then
            if mob:getAnimationSub() == 4 then
                curlUpEngaged(mob)
            end

            resetCount(mob)
        end
    end)
end

return g_mixins.families.wamouracampa
