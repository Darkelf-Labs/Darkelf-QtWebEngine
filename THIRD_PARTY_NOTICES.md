# Darkelf-QtWebEngine — Third-Party Notices

Darkelf-QtWebEngine provides Darkelf-specific patches, build configuration,
and tooling for building a customized version of Qt WebEngine.

Darkelf-specific original code, patches, scripts, and build tooling in this
repository are licensed under the **GNU Lesser General Public License version
3.0 (LGPL-3.0)** unless otherwise indicated.

Qt, Qt WebEngine, Chromium, FFmpeg, and other third-party components retain
their respective copyrights and licenses.

Nothing in the Darkelf-QtWebEngine license replaces, modifies, or supersedes
the license terms applicable to third-party software.

## Qt / Qt WebEngine

Darkelf-QtWebEngine is designed to modify and build Qt WebEngine.

Qt is developed by The Qt Company Ltd. and contributors and is available
under multiple licensing options. Darkelf-QtWebEngine uses and modifies Qt
WebEngine under the applicable open-source licensing terms, including the
GNU Lesser General Public License version 3 (LGPL-3.0), where applicable.

Qt WebEngine incorporates technology from the Chromium project and numerous
additional third-party open-source projects.

The Darkelf-QtWebEngine repository provides Darkelf-specific source patches
and build instructions so that the modifications can be reviewed and
reproduced from the corresponding Qt WebEngine source.

Project information:

* Qt: https://www.qt.io/
* Qt licensing: https://doc.qt.io/qt-6/licensing.html
* Qt third-party licenses: https://doc.qt.io/qt-6/licenses-used-in-qt.html

Copyright © The Qt Company Ltd. and other contributors.

## Chromium

Qt WebEngine incorporates source code from the Chromium project.

Chromium is an open-source browser project and includes components distributed
under the BSD 3-Clause license and numerous other open-source licenses.

Darkelf-QtWebEngine does not replace or supersede the licensing terms of
Chromium or its bundled third-party components.

Project information:

* Chromium: https://www.chromium.org/
* Chromium source: https://chromium.googlesource.com/chromium/src/

Copyright © The Chromium Authors and other contributors.

Individual Chromium third-party components retain their respective copyrights
and license terms.

## FFmpeg

Qt WebEngine / Chromium incorporates FFmpeg components for media functionality.

FFmpeg is primarily distributed under the **GNU Lesser General Public License
version 2.1 or later (LGPL-2.1-or-later)**, with some optional components and
configurations potentially subject to different licensing terms.

The Darkelf Qt WebEngine build configuration enables Chromium proprietary
codec support for additional media-format compatibility, including H.264/AVC
playback support.

Enabling codec support does not change the license of Darkelf-specific source
code, patches, or build tooling. FFmpeg and all other third-party components
remain subject to their respective license terms.

Project information:

* FFmpeg: https://ffmpeg.org/
* FFmpeg licensing: https://ffmpeg.org/legal.html

Copyright © FFmpeg developers and contributors.

## H.264 / AVC

The Darkelf Qt WebEngine build configuration includes support for H.264/AVC
media playback.

H.264/AVC is a standardized media format that may be covered by patents or
other intellectual-property rights in some jurisdictions.

The presence of H.264/AVC functionality in a Darkelf Qt WebEngine build does
not itself grant users, builders, or distributors any patent license beyond
rights that may otherwise apply.

Patent licensing for H.264/AVC is separate from the open-source licenses
governing Darkelf-QtWebEngine, Qt, Qt WebEngine, Chromium, FFmpeg, and other
components.

## Darkelf macOS WebAuthn / Touch ID Modifications

Darkelf-QtWebEngine includes Darkelf-specific modifications intended to enable
native macOS WebAuthn and Touch ID functionality within the customized
Qt WebEngine build.

These modifications are provided as source patches together with supporting
build configuration and tooling.

Darkelf-specific portions of these modifications are distributed under the
GNU Lesser General Public License version 3.0 (LGPL-3.0), while modified or
surrounding upstream Qt WebEngine and Chromium source remains subject to the
applicable upstream licenses and copyright notices.

Apple, macOS, Touch ID, and related Apple technologies and trademarks are
subject to Apple's applicable terms and intellectual-property rights.

Darkelf-QtWebEngine is not affiliated with or endorsed by Apple Inc.

## Other Third-Party Components

Qt WebEngine and Chromium incorporate numerous additional third-party software
components under BSD, MIT, Apache, ISC, LGPL, and other licenses.

Each third-party component retains its applicable copyright notices and
license terms.

The authoritative Qt third-party licensing information is available at:

https://doc.qt.io/qt-6/licenses-used-in-qt.html

Additional license information associated with Chromium and its bundled
third-party components is included with the corresponding Chromium and
Qt WebEngine source distributions.

Anyone building or redistributing a customized Qt WebEngine should retain and
comply with the applicable third-party notices and license requirements
associated with the particular source and binary components being distributed.

## Darkelf-QtWebEngine License

Darkelf-specific original source code, patches, scripts, build configuration,
and tooling contained in this repository are distributed under the:

**GNU Lesser General Public License version 3.0 (LGPL-3.0)**

unless a particular file states otherwise.

This license applies only to material for which Darkelf Labs or the applicable
Darkelf contributor holds the copyright and has authority to license.

It does not relicense Qt, Qt WebEngine, Chromium, FFmpeg, Apple software, or
any other third-party material.

Third-party and modified upstream files remain subject to their applicable
upstream licenses and copyright notices.

Copyright © Darkelf Labs / Darkelf-QtWebEngine contributors.