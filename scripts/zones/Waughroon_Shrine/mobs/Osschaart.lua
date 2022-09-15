-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Osschaart
-- KSNM: Copycat
-----------------------------------
local twoHourAbility =
{
    xi.jsa.MIGHTY_STRIKES,
    xi.jsa.HUNDRED_FISTS,
    xi.jsa.BENEDICTION,
    xi.jsa.MANAFONT,
    xi.jsa.CHAINSPELL,
    xi.jsa.PERFECT_DODGE,
    xi.jsa.INVINCIBLE,
    xi.jsa.BLOOD_WEAPON,
    xi.jsa.FAMILIAR,
    xi.jsa.SOUL_VOICE,
    xi.jsa.EES_KINDRED,
    xi.jsa.MEIKYO_SHISUI,
    xi.jsa.MIJIN_GAKURE,
    xi.jsa.CALL_WYVERN,
    xi.jsa.ASTRAL_FLOW,
    xi.jsa.AZURE_LORE,
    0, -- WILD_CARD,
    0, -- OVERDRIVE,
    0, -- TRANCE,
    0, -- TABULA_RASA,
    0, -- BOLSTER,
    0, -- ELEMENTAL_SFORZO,
}
local entity = {}

local function charm(mob)
    local battlefieldPlayers = mob:getBattlefield():getPlayers()
    local players = battlefieldPlayers[1]:getParty()

    for _, v in pairs(players) do
        if
            v ~= nil and
            v:getLocalVar("playerCharmed") ~= 1 and
            not (mob:hasStatusEffect(xi.effect.SLEEP_I) or mob:hasStatusEffect(xi.effect.SLEEP_II))
        then
            v:setPos(mob:getXPos() + 0.3, mob:getYPos(), mob:getZPos() + 0.3, mob:getRotPos())
            mob:useMobAbility(1337, v)
            v:setLocalVar("playerCharmed", 1)
            mob:setLocalVar("charmedJob", v:getMainJob())

            if players[#players] == v then
                mob:setLocalVar("charmReset", 1)
            end
            break
        end
    end

    if mob:getLocalVar("charmReset") == 1 then
        for _, v in pairs(players) do
            v:setLocalVar("playerCharmed", 0)
        end
        mob:setLocalVar("charmReset", 0)
    end
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("twoHour", 0)
    mob:setMod(xi.mod.SILENCERES, 70)
end

entity.onMobEngaged = function(mob)
    mob:setLocalVar("charmTimer", os.time() + 30)
end

entity.onMobFight = function(mob, target)
    local job = mob:getLocalVar("charmedJob")
    if mob:getLocalVar("charmTimer") < os.time() then
        mob:setLocalVar("charmTimer", os.time() + 30)
        charm(mob)
    end

    if
        mob:getHPP() < 35 and mob:getLocalVar("twoHour") == 0
    then
        mob:setLocalVar("twoHour", 1)
        mob:useMobAbility(twoHourAbility[job])
    end

end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
