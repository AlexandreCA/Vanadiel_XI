-- Initialisation de la base de données
local db = require("luasql.sqlite3").mysql_connect("localhost", "root", "password", "ffxi_database")

-- Unity Concord

local unityLeaders = {
    {id = 1, name = "Apururu", style = "Soutien"},
    {id = 2, name = "Ishwar", style = "Offensif"},
    {id = 3, name = "Sylvie", style = "Magie"},
}

local unityMembers = {}
local unityRankings = {}
local unityTasks = {
    {id = 1, description = "Vaincre 10 ennemis", points = 10, accolades = 5},
    {id = 2, description = "Collecter 5 objets rares", points = 15, accolades = 10},
    {id = 3, description = "Participer à une bataille Unity", points = 20, accolades = 15},
}

function joinUnity(player, unityID)
    for _, leader in ipairs(unityLeaders) do
        if leader.id == unityID then
            unityMembers[player:getID()] = {unityID = unityID, accolades = 0, points = 0, chatEnabled = true}
            db:query("INSERT INTO unity_members (player_id, unity_id, accolades, points) VALUES (?, ?, 0, 0)", player:getID(), unityID)
            player:PrintToPlayer("Vous avez rejoint l'unité : " .. leader.name)
            return
        end
    end
    player:PrintToPlayer("Unité non valide.")
end

function addAccoladesAndPoints(player, accolades, points)
    local member = unityMembers[player:getID()]
    if member then
        member.accolades = member.accolades + accolades
        member.points = member.points + points
        db:query("UPDATE unity_members SET accolades = ?, points = ? WHERE player_id = ?", member.accolades, member.points, player:getID())
        player:PrintToPlayer("Vous avez gagné " .. accolades .. " accolades et " .. points .. " points Unity. Total points : " .. member.points)
    else
        player:PrintToPlayer("Vous n'êtes pas affilié à une unité Unity.")
    end
end

function updateRankings()
    unityRankings = {}
    local result = db:query("SELECT player_id, unity_id, points FROM unity_members ORDER BY points DESC")
    for _, row in ipairs(result) do
        local unityID = row.unity_id
        local points = row.points
        if not unityRankings[unityID] then
            unityRankings[unityID] = {}
        end
        table.insert(unityRankings[unityID], {playerID = row.player_id, points = points})
    end
end

function showRankings(player, unityID)
    local rankings = unityRankings[unityID]
    if rankings then
        player:PrintToPlayer("Classement pour l'unité " .. unityLeaders[unityID].name .. ":")
        for rank, data in ipairs(rankings) do
            player:PrintToPlayer("#" .. rank .. " - Joueur ID: " .. data.playerID .. ", Points: " .. data.points)
        end
    else
        player:PrintToPlayer("Pas de classement disponible pour cette unité.")
    end
end

function showUnityTasks(player)
    player:PrintToPlayer("Tâches Unity disponibles :")
    for _, task in ipairs(unityTasks) do
        player:PrintToPlayer(task.id .. ". " .. task.description .. " - Points: " .. task.points .. ", Accolades: " .. task.accolades)
    end
end

function completeUnityTask(player, taskID)
    for _, task in ipairs(unityTasks) do
        if task.id == taskID then
            addAccoladesAndPoints(player, task.accolades, task.points)
            player:PrintToPlayer("Tâche accomplie : " .. task.description)
            return
        end
    end
    player:PrintToPlayer("ID de tâche non valide.")
end

function onCommand(player, command, args)
    if command == "unity" then
        local subCommand = args[1]
        if subCommand == "join" and args[2] then
            joinUnity(player, tonumber(args[2]))
        elseif subCommand == "add" and args[2] and args[3] then
            addAccoladesAndPoints(player, tonumber(args[2]), tonumber(args[3]))
        elseif subCommand == "rankings" and args[2] then
            showRankings(player, tonumber(args[2]))
        elseif subCommand == "tasks" then
            showUnityTasks(player)
        elseif subCommand == "complete" and args[2] then
            completeUnityTask(player, tonumber(args[2]))
        else
            player:PrintToPlayer("Commandes disponibles : /unity join [id], /unity add [accolades] [points], /unity rankings [id], /unity tasks, /unity complete [taskID]")
        end
    end
end
