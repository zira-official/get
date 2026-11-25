param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Arguments
)

$ErrorActionPreference = "Stop"
$Version = "0.1.0"

function Show-Help {
    Write-Host ""
    Write-Host "  GET - Git Easy Tool" -ForegroundColor Cyan
    Write-Host "  Version $Version"
    Write-Host "  Gestor de aplicaciones desde repositorios Git."
    Write-Host ""
    Write-Host "USO:" -ForegroundColor Yellow
    Write-Host "  get help"
    Write-Host "      Muestra esta ayuda."
    Write-Host ""
    Write-Host "  get version"
    Write-Host "      Muestra la version instalada."
    Write-Host ""
    Write-Host "  get info <URL>"
    Write-Host "      Muestra la URL recibida (consulta de Releases en desarrollo)."
    Write-Host ""
    Write-Host "FUENTES PREVISTAS:" -ForegroundColor Yellow
    Write-Host "  GitHub Releases"
    Write-Host "  GitLab Releases"
    Write-Host ""
    Write-Host "PLATAFORMA:" -ForegroundColor Yellow
    Write-Host "  Windows"
    Write-Host ""
    Write-Host "ESTADO:" -ForegroundColor DarkGray
    Write-Host "  La descarga e instalacion se incorporaran en proximas versiones."
    Write-Host ""
}

try {
    if (-not $Arguments -or $Arguments.Count -eq 0) {
        Show-Help
        exit 0
    }

    switch ($Arguments[0].ToLowerInvariant()) {
        { $_ -in "help", "--help", "-h", "/?" } {
            Show-Help
            exit 0
        }
        { $_ -in "version", "--version", "-v" } {
            Write-Host "GET $Version"
            exit 0
        }
        "info" {
            if ($Arguments.Count -lt 2) {
                Write-Host "Uso: get info <URL>" -ForegroundColor Yellow
                exit 2
            }
            $uri = $null
            if (-not [Uri]::TryCreate($Arguments[1], [UriKind]::Absolute, [ref]$uri) -or $uri.Scheme -ne "https") {
                Write-Host "GET: proporciona una URL HTTPS valida." -ForegroundColor Red
                exit 2
            }
            if ($uri.Host -notin @("github.com", "gitlab.com")) {
                Write-Host "GET: por ahora solo se admiten enlaces de GitHub y GitLab." -ForegroundColor Red
                exit 2
            }
            Write-Host "GET $Version"
            Write-Host "URL: $($uri.AbsoluteUri)"
            Write-Host "La consulta de Releases se incorporara en una proxima version."
            exit 0
        }
        default {
            Write-Host "GET: comando no reconocido: $($Arguments[0])" -ForegroundColor Red
            Write-Host "Escribe 'get help' para ver los comandos."
            exit 2
        }
    }
}
catch {
    Write-Host "GET: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
