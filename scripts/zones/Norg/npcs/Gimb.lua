-----------------------------------
-- Area: Norg
--  NPC: Gimb
-- Type: Begins the "Sahagin Key Quest" but it doesn't appear in the log. See http://wiki.ffxiclopedia.org/wiki/Sahagin_Key_Quest
-- !pos -4.975 -1.975 -44.039 252
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(69)
    player:setCharVar('SahaginKeyProgress', 1)
end

return entity
