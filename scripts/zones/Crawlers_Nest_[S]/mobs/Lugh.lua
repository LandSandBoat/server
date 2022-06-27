------------------------------
-- Area: Crawlers Nest [S]
--   NM: Lugh
------------------------------
mixins =
{
	require("scripts/mixins/fomor_hate"),
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage")
}
require("scripts/globals/magic")
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/weaponskillids")
require("scripts/globals/zone")
require("scripts/globals/job_utils/geomancer")
------------------------------
local entity = {}


entity.onMobSpawn = function(mob)
    -- All Mods Here Are Assigned For Initial Difficulty Tuning
	mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 50)
    mob:addMod(xi.mod.STR, 50)
    mob:addMod(xi.mod.VIT, 20)
    mob:addMod(xi.mod.INT, 50)
    mob:addMod(xi.mod.MND, 20)
    mob:addMod(xi.mod.CHR, 20)
    mob:addMod(xi.mod.AGI, 20)
    mob:addMod(xi.mod.DEX, 40)
    mob:setMod(xi.mod.DEFP, 0)
    mob:setMod(xi.mod.RATTP, 0)
    mob:setMod(xi.mod.FASTCAST, 10)
    -- Status Effecs Based On https://ffxiclopedia.fandom.com/wiki/Lugh
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 20, 0, 0)
    mob:addStatusEffect(xi.effect.REGAIN, 10, 1, 0)
    mob:addStatusEffect(xi.effect.REGEN, 30, 1, 0)
    -- Increasing Enfire for Standard Attack Round to 100 (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=129695&id=18303)
    mob:addStatusEffect(xi.effect.ENFIRE_II, 20, 0, 0)

    -- Revamping Movement Speed Bonus
    mob:addMod(xi.mod.MOVE, 12)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    -- 25% En-Paralyze
    if target:hasStatusEffect(xi.effect.PLAGUE) == false then
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PLAGUE, {chance = 25})
    end
end

entity.onMobFight = function(mob, target)

    -- Mighty Strikes
    -- Should Be Used Every 5 Minutes, Set to 50% Health As Baseline (https://ffxiclopedia.fandom.com/wiki/Lugh)
    local timer = mob:getLocalVar("LMightyStrikesTimer")
    if mob:getHPP() <= 50 then
        if os.time() > timer then
            mob:useMobAbility(688)
            mob:setLocalVar("LMightyStrikesTimer", os.time() + 300)
        end
    end

    -- 20 Yalm Intimidate Aura Wtih Might Strikes Active (https://ffxiclopedia.fandom.com/wiki/Lugh)
    -- This just silently removes and adds Intimidate. Has 20% proc chance.
    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) == true then
        local nearbyPlayers = xi.auraTarget.PLAYER(20)
        if nearbyPlayers == nil then return end
        for _,v in ipairs(nearbyPlayers) do
            local shouldintimidate = math.random(1, 10)
            if shouldintimidate >= 9 then
                if v:hasStatusEffect(xi.effect.INTIMIDATE) == true then
                    v:delStatusEffectSilent(xi.effect.INTIMIDATE)
                end
                v:addStatusEffectEx(xi.effect.INTIMIDATE,xi.effect.INTIMIDATE, 1, 0, 1)
            end
        end
    end
    
    -- Combat Tick Logic
    mob:addListener("COMBAT_TICK", "LUGH_CTICK", function(mob)
        local levelup = mob:getLocalVar("LLevelUp")

        if mob:getAnimationSub() == 1 then
            if levelup > 0 then
                -- Perform Level Up
                local levelupsum = mob:getLocalVar("TotalLevelUp")
                if levelupsum <= 20 then
                    mob:useMobAbility(2460)
                    mob:setLocalVar("TotalLevelUp", levelupsum + 1)
                end
                mob:setLocalVar("LLevelUp", 0)
                mob:setAnimationSub(0)
            -- Resets States And Mods
            else
                mob:setLocalVar("LLevelUp", 0)
                mob:setAnimationSub(0)
            end
        end
    end)

    -- Magic Enmity Handling
    -- Mob Should Have Little To No Enmity Control (https://ffxiclopedia.fandom.com/wiki/Lugh)
    mob:addListener("MAGIC_TAKE", "LUGH_MAGIC_TAKE", function(target, caster, spell)
        if
            target:getAnimationSub() == 0 and
            spell:tookEffect() and
            (caster:isPC() or caster:isPet())
        then
            target:addEnmity(caster, 1000, 1000)
        end
    end)

    -- Enmity Handling
    -- Mob Should Have Little To No Enmity Control (https://ffxiclopedia.fandom.com/wiki/Lugh)
    mob:addListener("TAKE_DAMAGE", "LUGH_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if attackType == xi.attackType.PHYSICAL then
            mob:addEnmity(attacker, 1000, 1000)
        end
    end)

    mob:addListener("WEAPONSKILL_TAKE", "LUGH_WEAPONSKILL_TAKE", function(target, attacker, skillid, tp, action)
        target:addEnmity(attacker, 1000, 1000)
    end)
end

entity.onMobDrawIn = function(mob, target)
    -- Arena Style Draw-In
    -- Should Draw Into A Single Point In the Room, Draws In Anyone In Range (https://ffxiclopedia.fandom.com/wiki/Lugh)
    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getZPos() < 214.00 or target:getZPos() > 240.00) and os.time() > drawInWait then
        target:setPos(-196.076, -0.447, 220.810)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getXPos() < -218.00 or target:getXPos() > -175.00) and os.time() > drawInWait then
        target:setPos(-196.076, -0.447, 220.810)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 34 then
        mob:setLocalVar("LLevelUp", 1)
        mob:setAnimationSub(1)
    end
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == (588 or 591 or 645) then
        mob:setLocalVar("LLevelUp", 1)
        mob:setAnimationSub(1)
    end
end

entity.onMobDisengage = function(mob)
    local levelupsum = mob:getLocalVar("TotalLevelUp")
    if mob:getHPP() < 100 or levelupsum > 0 then
        DespawnMob(17477708)
        mob:setLocalVar("TotalLevelUp", 0)
        mob:setLocalVar("LFightTimer", 0)
        mob:setLocalVar("MobPoof", 1)
    end
    mob:removeListener("LUGH_WEAPONSKILL_TAKE")
    mob:removeListener("LUGH_TAKE_DAMAGE")
    mob:removeListener("LUGH_MAGIC_TAKE")
end

entity.onMobDespawn = function(mob) 
    if mob:getLocalVar("MobPoof") == 1 then
        mob:showText(mob, zones[mob:getZoneID()].text.NM_DESPAWN)
        mob:setLocalVar("MobPoof", 0)
    end
end

entity.onMobDespawn = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 516)
    player:setTitle(xi.title.LUGH_EXORCIST)
end

return entity
