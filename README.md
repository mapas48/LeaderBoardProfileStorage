🎯 Propósito
Este sistema gestiona un Leaderboard personalizado en Roblox usando ProfileStore para mostrar las estadísticas de los jugadores (Coins, Rebirths y Speed) junto con su avatar, nombre y valor formateado (K, M, B). También controla la posición de cada entrada visualmente en el ScrollingFrame.

⚠️ Nota importante
🧠 Este README fue generado con ayuda de inteligencia artificial (IA).

✨ Siéntete libre de mejorar el código, adaptarlo o convertirlo en un sistema de leaderboard global (entre servidores) utilizando soluciones como DataStore globales o servicios externos (como Firebase, PlayFab, etc.). Actualmente, este leaderboard se basa en los datos de sesión (ProfileStore local al servidor).
📁 Archivos involucrados
1. LeaderBoard.lua
Módulo encargado de ordenar y mostrar los jugadores en la tabla.

Funciones clave:

Leaderboard.leaderBoard(stats, NameFolder, avatarFolder, valueFolder, category)

Extrae los datos de DataManager.profiles.

Ordena por el valor stats de mayor a menor.

Crea visualmente los elementos clonando una plantilla (nombre, avatar y valor).

Usa createNewPlayerBoard para posicionar y mostrar cada entrada.

Utilidades incluidas:

formatNumber(num): Convierte números grandes a formato K, M o B.

Usa CheckerPlayer para evitar mostrar el mismo jugador múltiples veces por categoría.

2. Resize.lua (módulo de posiciones visuales)
Contiene las coordenadas verticales (Y) para colocar los nombres, valores y avatares de los jugadores en el leaderboard.

Estructura:

rePosition.rePositionName: Posiciones Y para el texto del nombre.

rePosition.rePositionValue: Posiciones Y para el valor (Coins, Rebirths, Speed).

rePosition.rePositionImg: Posiciones Y para el avatar del jugador.

Se espera que estas posiciones coincidan con la plantilla (template) usada para clonar los elementos UI.

🛠️ Requisitos
Tener configurado DataManager.profiles con datos sincronizados desde ProfileStore.

Una plantilla visual (template) con 3 elementos en workspace.leaderboards.template:

Texto del nombre (TextLabel)

Imagen del avatar (ImageLabel)

Texto del valor (TextLabel)

Un ScrollingFrame dividido en tres carpetas: nombre, avatar, valor.

🧪 Ejemplo de uso
lua
Copiar
Editar
LeaderBoard.leaderBoard("Coins", CoinsNameFolder, CoinsAvatarFolder, CoinsValueFolder, "Coins")
Esto ordenará y mostrará los jugadores por monedas en la sección correspondiente.
