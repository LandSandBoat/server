-----------------------------------
-- Area: Nyzul Isle (Nashmeira's Plea)
--  Mob: Alexander
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    -- "Draw in" should only trigger when target is beyond 20' (out of Radiant_Sacrament range)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)

    mob:addListener("WEAPONSKILL_STATE_ENTER", "WS_START_MSG", function(mob, skillID)
        -- Radiant Sacrament
        if (skillID == 2141) then
            mob:showText(mob, ID.text.OFFER_THY_WORSHIP)
        -- Mega Holy
        elseif (skillID == 2142) then
            mob:showText(mob, ID.text.OPEN_THINE_EYES)
        -- Perfect Defense
        elseif (skillID == 2143) then
            mob:showText(mob, ID.text.CEASE_THY_STRUGGLES)
        -- Divine Spear
        elseif (skillID == 2144) then
            mob:showText(mob, ID.text.RELEASE_THY_SELF)
        -- Gospel of the Lost
        elseif (skillID == 2145) then
            mob:showText(mob, ID.text.BASK_IN_MY_GLORY)
        -- Void of Repentance
        elseif (skillID == 2146) then
            mob:showText(mob, ID.text.REPENT_THY_IRREVERENCE)
        -- Divine Judgement
        elseif (skillID == 2147) then
            mob:showText(mob, ID.text.ACCEPT_THY_DESTRUCTION)
            mob:showText(mob, ID.text.OMEGA_SPAM)
        end
    end)
end

function onMobEngaged(mob, target)
    mob:showText(mob, ID.text.SHALL_BE_JUDGED)
end

function onMobFight(mob, target)
    -- BG Wiki: "He will use this ability at 50% of his HP and several times again as his health decreases."
    -- ffxiclopedia: "Alexander will use this ability as his next TP move once its HP falls below 50%."
    if (mob:getHPP() <= 50 and mob:getTP() >= 1000 and mob:getLocalVar("DivineJudgement") == 0) then
        mob:setLocalVar("DivineJudgement", 1)
        mob:useMobAbility(2147)
    end

    -- ffxiclopedia: "In addition to this, it's possible he'll use it several times again at low (5%?) HP."
    -- Per same wiki, may use Perfect Defense as a regular skill at 10%..Assuming same % for both skills.
    local skill_list = mob:getMobMod(tpz.mobMod.SKILL_LIST)
    if (mob:getHPP() <= 10 and skill_list == 784) then
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 785)
    end
end

function onMobDeath(mob, player, isKiller)
    if (isKiller) then
        mob:showText(mob, ID.text.SHALL_KNOW_OBLIVION)
    end
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end
