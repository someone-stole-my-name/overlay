EAPI=7

inherit desktop

DESCRIPTION="2FA software"
HOMEPAGE="https://authy.com/"
SRC_URI="https://s3.amazonaws.com/authy-electron-repository-production/authy/stable/${PV}/win32/x64/Authy%20Desktop%20Setup%20${PV}.exe -> ${P}.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ELECTRON_V=11.4.0
ELECTRON_SLOT=11.4

DEPEND="
	>=dev-util/electron-${ELECTRON_V}:${ELECTRON_SLOT}
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/unzip
"
S="${WORKDIR}"

src_unpack() {
	unzip -a ${DISTDIR}/${P}.zip
	unzip -a ${P}-full.nupkg
}

src_prepare() {
	default
	cd ${S} && find . ! -name lib -maxdepth 1 -exec rm -rv {} \;
	mv ${S}/lib/net45/* ${S} && rm -r ${S}/lib
}
