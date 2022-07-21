-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Osschaart
-- KSNM: Copycat
-----------------------------------
twoHourAbility =
{
    688, -- mighty_strikes
    690, -- hundred_fists
    689, -- benediction
    691, -- manafont
    692, -- chainspell
    693, -- perfect_dodge
    694, -- invincible
    695, -- blood_weapon
    740, -- familiar
    696, -- soul_voice
    0, -- eagle_eye_shot NEEDS CAPTURE
    730, -- meikyo_shisui
    731, -- mijin_gakure
    1893, -- spirit_surge
    734, -- astral_flow
    1933, -- azure_lore
    0, -- wild_card
    0, -- overdrive
    0, -- trance
    0, -- tabula_rasa
    0, -- bolster
    0, -- elemental_sforzo
}
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("twoHour", 0)
end

entity.onMobEngaged = function(mob)
    mob:setLocalVar("charmTimer", os.time() + 30)
end

local function charm(mob)
    local battlefieldPlayers = mob:getBattlefield():getPlayers()
    local players = battlefieldPlayers[1]:getParty()

    for _, v in pairs(players) do
        if v ~= nil and v:getLocalVar("playerCharmed") ~= 1 then
            mob:updateEnmity(v)
            v:setPos(mob:getXPos() + 0.3, mob:getYPos(), mob:getZPos() + 0.3, mob:getRotPos())
            mob:useMobAbility(1337, v)
            v:setLocalVar("playerCharmed", 1)
            mob:setLocalVar("charmTimer", os.time() + 30)
            mob:setLocalVar("charmedJob", v:getMainJob())

            if players[#players] == v then
                mob:setLocalVar("charmReset", 1)
            end

            break
        end
    end

    if mob:getLocalVar("charmReset") ~= 0 then
        for _, v in pairs(players) do
            v:setLocalVar("playerCharmed", 0)
        end
        mob:setLocalVar("charmReset", 0)
    end
end

local function useTwoHour(mob)

end

entity.onMobFight = function(mob, target)
    local job = mob:getLocalVar("charmedJob")
    print(job)
    print(twoHourAbility[job])
    if mob:getLocalVar("charmTimer") < os.time() then
        charm(mob)
    end

    if
        mob:getHPP() < 35 and mob:getLocalVar("twoHour") == 0
    then
        mob:setLocalVar("twoHour", 1)
        print(twoHourAbility[job])
        mob:useMobAbility(twoHourAbility[job])
    end

end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
