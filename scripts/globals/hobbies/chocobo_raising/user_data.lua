-----------------------------------
-- Chocobo Raising - User Data
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/model')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

-----------------------------------
-- Tables
-----------------------------------
-- Bits of char_pet.chocobo_user_data flags. Char vars hold only state that returns to 0.
---@enum xi.chocoboRaising.userFlag
xi.chocoboRaising.userFlag =
{
    WHISTLE_QUEST_DONE = 0x1,
    HANDKERCHIEF_DONE  = 0x2,
    MET_DIETMUND       = 0x4,
}

local userFlag = xi.chocoboRaising.userFlag

-----------------------------------
-- Helpers
-----------------------------------
-- A progress char var until the terminal state, then a user flag.
local function progress(player, var, flag, done)
    if xi.chocoboRaising.hasUserFlag(player, flag) then
        return done
    end

    return player:getCharVar(var)
end

local function setProgress(player, var, flag, done, value)
    if value == done then
        xi.chocoboRaising.setUserFlag(player, flag)
        player:setCharVar(var, 0)
        return
    end

    xi.chocoboRaising.clearUserFlag(player, flag)
    player:setCharVar(var, value)
end

-----------------------------------
-- Global Functions
-----------------------------------
---@param player CBaseEntity
---@param flag xi.chocoboRaising.userFlag
---@return boolean
xi.chocoboRaising.hasUserFlag = function(player, flag)
    return bit.band(player:getChocoboUserData().flags, flag) ~= 0
end

---@param player CBaseEntity
---@param flag xi.chocoboRaising.userFlag
---@return nil
xi.chocoboRaising.setUserFlag = function(player, flag)
    player:setChocoboUserData({ flags = bit.bor(player:getChocoboUserData().flags, flag) })
end

---@param player CBaseEntity
---@param flag xi.chocoboRaising.userFlag
---@return nil
xi.chocoboRaising.clearUserFlag = function(player, flag)
    player:setChocoboUserData({ flags = bit.band(player:getChocoboUserData().flags, bit.bnot(flag)) })
end

---@param player CBaseEntity
---@return nil
xi.chocoboRaising.addChocoboRaised = function(player)
    player:setChocoboUserData({ chocobosRaised = player:getChocoboUserData().chocobosRaised + 1 })
end

---@param player CBaseEntity
---@return xi.chocoboRaising.handkerchief
xi.chocoboRaising.handkerchiefState = function(player)
    return progress(player, xi.chocoboRaising.handkerchiefVar, userFlag.HANDKERCHIEF_DONE, xi.chocoboRaising.handkerchief.DONE)
end

---@param player CBaseEntity
---@param state xi.chocoboRaising.handkerchief
---@return nil
xi.chocoboRaising.setHandkerchiefState = function(player, state)
    setProgress(player, xi.chocoboRaising.handkerchiefVar, userFlag.HANDKERCHIEF_DONE, xi.chocoboRaising.handkerchief.DONE, state)
end

---@param player CBaseEntity
---@return xi.chocoboRaising.whistleProg
xi.chocoboRaising.whistleProgress = function(player)
    return progress(player, xi.chocoboRaising.whistleQuestVar, userFlag.WHISTLE_QUEST_DONE, xi.chocoboRaising.whistleProg.DONE)
end

---@param player CBaseEntity
---@param prog xi.chocoboRaising.whistleProg
---@return nil
xi.chocoboRaising.setWhistleProgress = function(player, prog)
    setProgress(player, xi.chocoboRaising.whistleQuestVar, userFlag.WHISTLE_QUEST_DONE, xi.chocoboRaising.whistleProg.DONE, prog)
end
