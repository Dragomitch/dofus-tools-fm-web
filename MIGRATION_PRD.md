# Product Requirements Document (PRD)
## Migration: Dofus Tools from Python/HTML/JS to Java 26 + Spring Boot 3.x + Angular 20

---

## Table of Contents
1. [Executive Summary](#executive-summary)
2. [Current Application Analysis](#current-application-analysis)
3. [Migration Objectives](#migration-objectives)
4. [Technology Stack](#technology-stack)
5. [Application Architecture](#application-architecture)
6. [Data Models](#data-models)
7. [Backend Implementation Details](#backend-implementation-details)
8. [Frontend Implementation Details](#frontend-implementation-details)
9. [Migration Strategy](#migration-strategy)
10. [Testing Requirements](#testing-requirements)
11. [Deployment Strategy](#deployment-strategy)
12. [Timeline and Milestones](#timeline-and-milestones)

---

## 1. Executive Summary

### 1.1 Current State
The Dofus Tools application is a web-based forgemagie (item enhancement) calculator for the MMORPG game Dofus. It is currently built with:
- **Backend**: Python scripts for web scraping
- **Frontend**: Vanilla JavaScript, jQuery, jQuery UI, Bootstrap
- **Architecture**: Static HTML pages with client-side logic

### 1.2 Target State
Migrate to a modern, scalable, enterprise-ready architecture:
- **Backend**: Java 26 + Spring Boot 3.x (LTS)
- **Frontend**: Angular 20
- **Architecture**: RESTful API with SPA (Single Page Application)

### 1.3 Key Benefits
- Type safety with Java and TypeScript
- Improved maintainability and testability
- Modern development practices
- Better performance and scalability
- Enhanced security
- Reactive programming capabilities
- Better separation of concerns

---

## 2. Current Application Analysis

### 2.1 Application Structure

```
dofus-tools-fm-web/
├── css/
│   └── main.css                 # Custom styles
├── images/
│   ├── favicon.png
│   ├── dofus_forgemagie-logo.png
│   └── runes/                   # 103 rune images
├── js/
│   ├── runes.js                 # Rune data array (103 runes)
│   ├── runecomplete.js          # Autocomplete widget
│   └── forgemagie.js            # Main application logic
├── py/
│   ├── download_all_runes.py    # Web scraping for rune images
│   ├── retrieve_runes_list.py   # Generate JS rune data
│   └── libs/
│       └── EzWebScraping.py     # Web scraping utility
├── vendor/
│   ├── bootstrap/
│   ├── fontawesome/
│   └── jquery/
├── index.html                   # Landing page
└── forgemagie.html              # Main calculator page
```

### 2.2 Core Features

#### 2.2.1 Rune Management
- **Rune Data**: Array of 103 runes with properties:
  - `label`: String (e.g., "Rune Age")
  - `category`: String (e.g., "Runes de type simple", "Runes de type Pa", "Runes de type Ra")
  - `icon`: String (path to image)
  - `weight`: Number/String (e.g., "1", "2.5", "100")

#### 2.2.2 Autocomplete Widget
- Custom jQuery UI widget extending `ui.autocomplete`
- Features:
  - Categorized dropdown list
  - Icon display for each rune
  - Weight display
  - Autocorrect functionality (max 2 character difference)
  - Keyboard navigation (Enter key to select first item)
  - Click to open dropdown
  - Form validation (valid/invalid states)

**Key Algorithm**: String comparison using letter occurrence matching
```javascript
compareStrings(str1, str2) {
  // Converts strings to letter occurrence arrays (a-z)
  // Returns absolute difference sum
}
```

#### 2.2.3 Forgemagie Calculator Features

##### Feature 1: Calculate PUIT (Well)
- **Inputs**:
  - Rune that was removed (`rune-removed`)
  - Rune that was added (`rune-added`)
- **Logic**: `puit = weight(removed) - weight(added)`
- **Output**:
  - Updates main puit counter
  - Displays calculation formula
  - Adds entry to history with timestamp

##### Feature 2: Subtract Rune from PUIT
- **Input**: Rune to pass using puit (`rune-to-remove`)
- **Logic**: `puit = puit - weight(rune)`
- **Output**:
  - Updates puit counter
  - Displays "last rune removed" with icon and name
  - Adds entry to history with timestamp

##### Feature 3: Calculate Number of Runes
- **Input**: Rune to add using puit (`runes-to-add`)
- **Logic**:
  - `number = floor(puit / weight(rune))`
  - `remainder = puit % weight(rune)`
- **Output**:
  - Displays number of runes that can be added
  - Shows remaining puit if any

##### Feature 4: Manual PUIT Adjustment
- **Inputs**: Buttons for +/- 1, 2, 3, 5
- **Logic**: Simple addition/subtraction (no negative values)
- **Output**: Updates puit counter and history

##### Feature 5: History Tracking
- Chronological list of all operations
- Each entry shows:
  - Rune icon(s)
  - Operation description
  - Timestamp (HH:MM format)
  - Running total

### 2.3 Python Scripts Analysis

#### 2.3.1 download_all_runes.py
**Purpose**: Web scrape rune images from Dofus encyclopedia

**Logic**:
```python
1. Connect to: https://www.dofus.com/fr/mmorpg/encyclopedie/ressources?type_id[]=78&object_level_min=1&object_level_max=200&size=96
2. Parse HTML table with class "ak-table ak-responsivetable"
3. For each <tr>:
   - Extract image URL from first <td>
   - Extract rune name from second <td>
   - Calculate weight using get_rune_weight()
   - Download image to: images/runes/{name} ({weight}).png
```

**Weight Calculation Logic**:
```python
Base weights:
- 1: Fo, Ine, Cha, Age, Ini, Vi
- 2: Puit, Ré Terre, Ré Feu, Ré Eau, Ré Air, Ré Neutre, Ré Pou, Ré Cri, Pi Per
- 2.5: Pod
- 3: Sa, Prospe
- 4: Tac, Fui
- 5: Do Terre, Do Feu, Do Eau, Do Air, Do Neutre, Do Pou, Do Cri, Pi
- 6: Ré Per Terre, Ré Per Feu, Ré Per Eau, Ré Per Air, Ré Per Neutre
- 7: Ré Pa, Ré Pme, Ret Pa, Ret Pme
- 10: So, Cri, Do Ren
- 15: Do Per Mé, Do Per Di, Do Per Ar, Do Per So, Ré Per Mé, Ré Per Di
- 20: Do
- 30: Invo
- 51: Po
- 90: Ga Pme
- 100: Ga Pa

Multiplicators:
- "Rune Pa" prefix: x3
- "Rune Ra" prefix: x10
- Default: x1

Final weight = base_weight * multiplicator
```

#### 2.3.2 retrieve_runes_list.py
**Purpose**: Generate JavaScript rune array from downloaded images

**Logic**:
```python
1. Scan images/runes/ directory for "Rune*.png" files
2. For each file:
   - Parse filename to extract name and weight
   - Determine category (simple/Pa/Ra) based on prefix
   - Generate JS object: { label, category, icon, weight }
3. Output JS array declaration
```

#### 2.3.3 EzWebScraping.py
**Purpose**: HTTP session management and web scraping utility

**Features**:
- Session management with automatic reset on domain change
- GET/POST request support
- Referer header management
- URL validation
- HTML content extraction

---

## 3. Migration Objectives

### 3.1 Functional Requirements
- ✅ Maintain 100% feature parity with current application
- ✅ Preserve all calculator functionality
- ✅ Maintain rune data and images
- ✅ Keep French language support
- ✅ Preserve UI/UX design (Bootstrap-based)

### 3.2 Non-Functional Requirements
- ✅ Type-safe backend (Java) and frontend (TypeScript)
- ✅ RESTful API architecture
- ✅ Responsive design (mobile-first)
- ✅ SEO optimization
- ✅ Performance: Page load < 2s
- ✅ Accessibility (WCAG 2.1 Level AA)
- ✅ Cross-browser compatibility (Chrome, Firefox, Safari, Edge)

### 3.3 Technical Requirements
- ✅ Java 26 with virtual threads
- ✅ Spring Boot 3.4.x (latest LTS)
- ✅ Angular 20 with standalone components
- ✅ PostgreSQL or H2 database
- ✅ Docker containerization
- ✅ CI/CD pipeline ready

---

## 4. Technology Stack

### 4.1 Backend Stack

| Component | Technology | Version | Purpose |
|-----------|-----------|---------|---------|
| Runtime | Java | 26 | Core language |
| Framework | Spring Boot | 3.4.x | Application framework |
| Web | Spring Web MVC | 3.4.x | REST API |
| Data | Spring Data JPA | 3.4.x | Data access layer |
| Database | H2 / PostgreSQL | Latest | Data storage |
| Validation | Jakarta Validation | 3.x | Input validation |
| Documentation | SpringDoc OpenAPI | 2.x | API documentation |
| Testing | JUnit 5 | Latest | Unit testing |
| Testing | Mockito | Latest | Mocking framework |
| Build | Maven | 3.9.x | Build tool |
| Web Scraping | Jsoup | 1.17.x | HTML parsing |
| HTTP Client | Spring WebClient | 3.4.x | Reactive HTTP client |

### 4.2 Frontend Stack

| Component | Technology | Version | Purpose |
|-----------|-----------|---------|---------|
| Framework | Angular | 20 | SPA framework |
| Language | TypeScript | 5.x | Type-safe development |
| UI Library | Angular Material | 20 | UI components |
| Icons | Font Awesome | 6.x | Icon library |
| Forms | Angular Reactive Forms | 20 | Form management |
| HTTP | Angular HttpClient | 20 | API communication |
| Routing | Angular Router | 20 | Navigation |
| Build | Angular CLI | 20 | Build tooling |
| Testing | Jasmine + Karma | Latest | Unit testing |
| E2E Testing | Playwright | Latest | End-to-end testing |

### 4.3 DevOps Stack

| Component | Technology | Purpose |
|-----------|-----------|---------|
| Containerization | Docker | Application packaging |
| Orchestration | Docker Compose | Local development |
| Version Control | Git | Source control |
| CI/CD | GitHub Actions | Automation |

---

## 5. Application Architecture

### 5.1 Overall Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Angular 20 SPA                        │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Components                                            │  │
│  │  - LandingComponent                                    │  │
│  │  - ForgemagieCalculatorComponent                       │  │
│  │  - RuneAutocompleteComponent                           │  │
│  │  - HistoryComponent                                    │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Services                                              │  │
│  │  - RuneService                                         │  │
│  │  - CalculatorService                                   │  │
│  │  - HistoryService                                      │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ HTTP REST API
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                   Spring Boot 3.x Backend                    │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Controllers (REST)                                    │  │
│  │  - RuneController                                      │  │
│  │  - CalculatorController                                │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Services (Business Logic)                             │  │
│  │  - RuneService                                         │  │
│  │  - CalculatorService                                   │  │
│  │  - WebScrapingService                                  │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Repositories (Data Access)                            │  │
│  │  - RuneRepository (JPA)                                │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
                    ┌───────────────┐
                    │   Database    │
                    │  (H2/PostgreSQL)│
                    └───────────────┘
```

### 5.2 Backend Architecture (Layered)

```
┌──────────────────────────────────────────┐
│          Presentation Layer              │
│  - REST Controllers                      │
│  - DTOs (Data Transfer Objects)          │
│  - Request/Response Models               │
│  - Exception Handlers                    │
└──────────────────────────────────────────┘
                    │
┌──────────────────────────────────────────┐
│         Business Logic Layer             │
│  - Services                              │
│  - Business Rules                        │
│  - Calculator Logic                      │
│  - String Matching Algorithm             │
└──────────────────────────────────────────┘
                    │
┌──────────────────────────────────────────┐
│          Data Access Layer               │
│  - JPA Repositories                      │
│  - Entity Models                         │
│  - Database Queries                      │
└──────────────────────────────────────────┘
                    │
┌──────────────────────────────────────────┐
│           Database Layer                 │
│  - H2 (Dev) / PostgreSQL (Prod)          │
└──────────────────────────────────────────┘
```

### 5.3 Frontend Architecture (Component-Based)

```
┌──────────────────────────────────────────────────────────┐
│                   App Component (Root)                    │
│  - Navigation Bar                                         │
│  - Router Outlet                                          │
└──────────────────────────────────────────────────────────┘
                    │
        ┌───────────┴───────────┐
        │                       │
┌───────▼──────────┐   ┌───────▼────────────────────┐
│  Landing Page    │   │ Forgemagie Calculator Page │
│  Component       │   │  Component                 │
└──────────────────┘   └────────────────────────────┘
                                │
            ┌───────────────────┼────────────────────┐
            │                   │                    │
    ┌───────▼────────┐  ┌───────▼────────┐  ┌───────▼────────┐
    │ Rune Input     │  │ PUIT Counter   │  │ History Panel  │
    │ Component      │  │ Component      │  │ Component      │
    │ (Autocomplete) │  │                │  │                │
    └────────────────┘  └────────────────┘  └────────────────┘

Shared Services Layer:
┌─────────────────────────────────────────────────────────┐
│ RuneService | CalculatorService | HistoryService        │
└─────────────────────────────────────────────────────────┘
```

---

## 6. Data Models

### 6.1 Backend Data Models (Java Entities)

#### 6.1.1 Rune Entity
```java
@Entity
@Table(name = "runes")
public class Rune {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 100)
    private String label;  // "Rune Age"

    @Column(nullable = false, length = 50)
    @Enumerated(EnumType.STRING)
    private RuneCategory category;  // SIMPLE, PA, RA

    @Column(nullable = false, length = 255)
    private String iconPath;  // "images/runes/Rune Age (1).png"

    @Column(nullable = false, precision = 5, scale = 2)
    private BigDecimal weight;  // 1, 2.5, 100, etc.

    @Column(nullable = true, length = 500)
    private String description;

    @CreatedDate
    private LocalDateTime createdAt;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    // Constructors, getters, setters, equals, hashCode
}
```

#### 6.1.2 RuneCategory Enum
```java
public enum RuneCategory {
    SIMPLE("Runes de type simple"),
    PA("Runes de type Pa"),
    RA("Runes de type Ra");

    private final String displayName;

    RuneCategory(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
```

#### 6.1.3 CalculationHistory Entity (Optional for persistence)
```java
@Entity
@Table(name = "calculation_history")
public class CalculationHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String sessionId;  // For grouping calculations

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private OperationType operationType;  // CALCULATE_PUIT, SUBTRACT_RUNE, etc.

    @ManyToOne
    @JoinColumn(name = "rune_removed_id")
    private Rune runeRemoved;

    @ManyToOne
    @JoinColumn(name = "rune_added_id")
    private Rune runeAdded;

    @Column(nullable = false)
    private BigDecimal puitBefore;

    @Column(nullable = false)
    private BigDecimal puitAfter;

    @Column(nullable = false)
    private LocalDateTime timestamp;

    // Constructors, getters, setters
}
```

### 6.2 Backend DTOs

#### 6.2.1 RuneDTO
```java
public record RuneDTO(
    Long id,
    String label,
    String category,
    String icon,
    BigDecimal weight
) {
    public static RuneDTO from(Rune rune) {
        return new RuneDTO(
            rune.getId(),
            rune.getLabel(),
            rune.getCategory().getDisplayName(),
            rune.getIconPath(),
            rune.getWeight()
        );
    }
}
```

#### 6.2.2 CalculatePuitRequest
```java
public record CalculatePuitRequest(
    @NotNull String runeRemovedLabel,
    @NotNull String runeAddedLabel
) {}
```

#### 6.2.3 CalculatePuitResponse
```java
public record CalculatePuitResponse(
    BigDecimal puit,
    BigDecimal runeRemovedWeight,
    BigDecimal runeAddedWeight,
    String calculation  // "90 - 3 = 87"
) {}
```

#### 6.2.4 SubtractRuneRequest
```java
public record SubtractRuneRequest(
    @NotNull BigDecimal currentPuit,
    @NotNull String runeLabel
) {}
```

#### 6.2.5 SubtractRuneResponse
```java
public record SubtractRuneResponse(
    BigDecimal newPuit,
    BigDecimal subtractedWeight,
    String calculation  // "87 - 9 = 78"
) {}
```

#### 6.2.6 CalculateRuneCountRequest
```java
public record CalculateRuneCountRequest(
    @NotNull BigDecimal currentPuit,
    @NotNull String runeLabel
) {}
```

#### 6.2.7 CalculateRuneCountResponse
```java
public record CalculateRuneCountResponse(
    Integer count,
    BigDecimal remainder,
    String message  // "Il restera X de puit" or empty
) {}
```

#### 6.2.8 RuneAutocorrectRequest
```java
public record RuneAutocorrectRequest(
    @NotBlank String input,
    @Min(1) @Max(10) Integer maxGap  // Default: 2
) {}
```

#### 6.2.9 RuneAutocorrectResponse
```java
public record RuneAutocorrectResponse(
    String correctedValue,
    boolean success,
    Integer gap
) {}
```

### 6.3 Frontend Data Models (TypeScript Interfaces)

#### 6.3.1 Rune Interface
```typescript
export interface Rune {
  id: number;
  label: string;
  category: string;
  icon: string;
  weight: number;
}
```

#### 6.3.2 RuneCategory Type
```typescript
export type RuneCategory = 'Runes de type simple' | 'Runes de type Pa' | 'Runes de type Ra';
```

#### 6.3.3 HistoryEntry Interface
```typescript
export interface HistoryEntry {
  id: string;  // UUID
  operationType: OperationType;
  description: string;
  runeIcons: string[];
  timestamp: Date;
  puitTotal: number;
  details?: string;
}
```

#### 6.3.4 OperationType Enum
```typescript
export enum OperationType {
  CALCULATE_PUIT = 'CALCULATE_PUIT',
  SUBTRACT_RUNE = 'SUBTRACT_RUNE',
  MANUAL_ADD = 'MANUAL_ADD',
  MANUAL_SUBTRACT = 'MANUAL_SUBTRACT',
  CALCULATE_RUNE_COUNT = 'CALCULATE_RUNE_COUNT'
}
```

#### 6.3.5 CalculatorState Interface
```typescript
export interface CalculatorState {
  puit: number;
  history: HistoryEntry[];
  lastRuneRemoved?: {
    name: string;
    icon: string;
    weight: number;
  };
  runeCount?: {
    rune: Rune;
    count: number;
    remainder: number;
  };
}
```

---

## 7. Backend Implementation Details

### 7.1 Project Structure

```
src/main/java/com/dofustools/
├── DofusToolsApplication.java
├── config/
│   ├── CorsConfig.java
│   ├── WebConfig.java
│   └── OpenApiConfig.java
├── controller/
│   ├── RuneController.java
│   ├── CalculatorController.java
│   └── WebScrapingController.java
├── service/
│   ├── RuneService.java
│   ├── CalculatorService.java
│   ├── WebScrapingService.java
│   └── StringMatchingService.java
├── repository/
│   └── RuneRepository.java
├── model/
│   ├── entity/
│   │   ├── Rune.java
│   │   └── CalculationHistory.java
│   ├── dto/
│   │   ├── request/
│   │   │   ├── CalculatePuitRequest.java
│   │   │   ├── SubtractRuneRequest.java
│   │   │   ├── CalculateRuneCountRequest.java
│   │   │   └── RuneAutocorrectRequest.java
│   │   └── response/
│   │       ├── RuneDTO.java
│   │       ├── CalculatePuitResponse.java
│   │       ├── SubtractRuneResponse.java
│   │       ├── CalculateRuneCountResponse.java
│   │       └── RuneAutocorrectResponse.java
│   └── enums/
│       ├── RuneCategory.java
│       └── OperationType.java
├── exception/
│   ├── RuneNotFoundException.java
│   ├── InvalidCalculationException.java
│   └── GlobalExceptionHandler.java
└── util/
    ├── RuneWeightCalculator.java
    └── ImageDownloadUtil.java

src/main/resources/
├── application.yml
├── application-dev.yml
├── application-prod.yml
├── db/migration/
│   └── V1__initial_schema.sql
└── static/
    └── images/
        └── runes/

src/test/java/com/dofustools/
├── controller/
├── service/
└── integration/
```

### 7.2 REST API Endpoints

#### 7.2.1 Rune Management Endpoints

**GET /api/v1/runes**
- Description: Get all runes
- Response: `List<RuneDTO>`
- Query params:
  - `category` (optional): Filter by category
  - `search` (optional): Search by label

**GET /api/v1/runes/{id}**
- Description: Get rune by ID
- Response: `RuneDTO`
- Throws: `RuneNotFoundException`

**GET /api/v1/runes/by-label/{label}**
- Description: Get rune by exact label
- Response: `RuneDTO`
- Throws: `RuneNotFoundException`

**POST /api/v1/runes/autocorrect**
- Description: Autocorrect rune name
- Request: `RuneAutocorrectRequest`
- Response: `RuneAutocorrectResponse`

**GET /api/v1/runes/categories**
- Description: Get all categories
- Response: `List<String>`

#### 7.2.2 Calculator Endpoints

**POST /api/v1/calculator/calculate-puit**
- Description: Calculate PUIT from two runes
- Request: `CalculatePuitRequest`
- Response: `CalculatePuitResponse`
- Logic: `puit = weight(removed) - weight(added)`

**POST /api/v1/calculator/subtract-rune**
- Description: Subtract rune weight from PUIT
- Request: `SubtractRuneRequest`
- Response: `SubtractRuneResponse`
- Logic: `newPuit = currentPuit - weight(rune)`

**POST /api/v1/calculator/calculate-rune-count**
- Description: Calculate how many runes can be added
- Request: `CalculateRuneCountRequest`
- Response: `CalculateRuneCountResponse`
- Logic: `count = floor(puit / weight), remainder = puit % weight`

#### 7.2.3 Admin/Maintenance Endpoints

**POST /api/v1/admin/scrape-runes**
- Description: Trigger web scraping for runes
- Response: `{ status: "success", count: 103 }`
- Authorization: Admin only

**POST /api/v1/admin/sync-database**
- Description: Sync runes from files to database
- Response: `{ status: "success", count: 103 }`

### 7.3 Core Business Logic Implementation

#### 7.3.1 CalculatorService
```java
@Service
@Slf4j
public class CalculatorService {

    private final RuneService runeService;

    public CalculatorService(RuneService runeService) {
        this.runeService = runeService;
    }

    /**
     * Calculate PUIT based on removed and added runes
     * Formula: puit = weight(removed) - weight(added)
     */
    public CalculatePuitResponse calculatePuit(CalculatePuitRequest request) {
        Rune runeRemoved = runeService.findByLabel(request.runeRemovedLabel());
        Rune runeAdded = runeService.findByLabel(request.runeAddedLabel());

        BigDecimal puit = runeRemoved.getWeight().subtract(runeAdded.getWeight());

        String calculation = String.format("%s - %s = %s",
            runeRemoved.getWeight(),
            runeAdded.getWeight(),
            puit
        );

        return new CalculatePuitResponse(
            puit,
            runeRemoved.getWeight(),
            runeAdded.getWeight(),
            calculation
        );
    }

    /**
     * Subtract rune weight from current PUIT
     */
    public SubtractRuneResponse subtractRune(SubtractRuneRequest request) {
        Rune rune = runeService.findByLabel(request.runeLabel());

        BigDecimal newPuit = request.currentPuit().subtract(rune.getWeight());

        if (newPuit.compareTo(BigDecimal.ZERO) < 0) {
            throw new InvalidCalculationException(
                "PUIT cannot be negative. Current: " + request.currentPuit() +
                ", Subtracting: " + rune.getWeight()
            );
        }

        String calculation = String.format("%s - %s = %s",
            request.currentPuit(),
            rune.getWeight(),
            newPuit
        );

        return new SubtractRuneResponse(newPuit, rune.getWeight(), calculation);
    }

    /**
     * Calculate number of runes that can be added with current PUIT
     */
    public CalculateRuneCountResponse calculateRuneCount(CalculateRuneCountRequest request) {
        Rune rune = runeService.findByLabel(request.runeLabel());

        BigDecimal weight = rune.getWeight();
        int count = request.currentPuit().divideToIntegralValue(weight).intValue();
        BigDecimal remainder = request.currentPuit().remainder(weight);

        String message = "";
        if (remainder.compareTo(BigDecimal.ZERO) > 0) {
            message = "Il restera " + remainder + " de puit.";
        }

        return new CalculateRuneCountResponse(count, remainder, message);
    }
}
```

#### 7.3.2 StringMatchingService
```java
@Service
public class StringMatchingService {

    /**
     * Autocorrect input string to closest rune label
     * Algorithm: Letter occurrence matching
     *
     * @param input User input
     * @param runes List of all runes
     * @param maxGap Maximum allowed character difference
     * @return Autocorrection result
     */
    public RuneAutocorrectResponse autocorrect(String input, List<Rune> runes, int maxGap) {
        if (input == null || input.isBlank()) {
            return new RuneAutocorrectResponse(input, false, 0);
        }

        int minGap = Integer.MAX_VALUE;
        String closestRune = input;

        for (Rune rune : runes) {
            int gap = compareStrings(refactorString(rune.getLabel()), refactorString(input));
            if (gap < minGap) {
                minGap = gap;
                closestRune = rune.getLabel();
            }
        }

        boolean success = minGap <= maxGap;
        return new RuneAutocorrectResponse(
            success ? closestRune : input,
            success,
            minGap
        );
    }

    /**
     * Compare two strings by letter occurrence
     * Returns absolute difference sum
     */
    private int compareStrings(String str1, String str2) {
        int[] occ1 = getLetterOccurrences(str1);
        int[] occ2 = getLetterOccurrences(str2);

        int diff = 0;
        for (int i = 0; i < 26; i++) {
            diff += Math.abs(occ1[i] - occ2[i]);
        }

        return diff;
    }

    /**
     * Get letter occurrence array (a-z)
     */
    private int[] getLetterOccurrences(String str) {
        int[] occ = new int[26];
        for (char c : str.toCharArray()) {
            if (c >= 'a' && c <= 'z') {
                occ[c - 'a']++;
            }
        }
        return occ;
    }

    /**
     * Refactor string for comparison:
     * - Lowercase
     * - Remove spaces
     * - Remove "rune"
     * - Remove accents (é -> e)
     * - Keep only a-z
     */
    private String refactorString(String str) {
        return str.toLowerCase()
            .replaceAll("\\s+", "")
            .replace("rune", "")
            .replace("é", "e")
            .replaceAll("[^a-z]", "");
    }
}
```

#### 7.3.3 WebScrapingService
```java
@Service
@Slf4j
public class WebScrapingService {

    private static final String DOFUS_RUNES_URL =
        "https://www.dofus.com/fr/mmorpg/encyclopedie/ressources?type_id%5B%5D=78&object_level_min=1&object_level_max=200&size=96";

    private final RuneWeightCalculator weightCalculator;
    private final ImageDownloadUtil imageDownloadUtil;

    /**
     * Scrape all runes from Dofus encyclopedia
     */
    public List<ScrapedRune> scrapeRunes() throws IOException {
        log.info("Starting rune scraping from: {}", DOFUS_RUNES_URL);

        Document doc = Jsoup.connect(DOFUS_RUNES_URL).get();
        Elements rows = doc.select("table.ak-table.ak-responsivetable tbody tr");

        List<ScrapedRune> runes = new ArrayList<>();

        for (Element row : rows) {
            try {
                String imageUrl = extractImageUrl(row);
                String name = extractName(row);
                BigDecimal weight = weightCalculator.calculateWeight(name);

                String localImagePath = imageDownloadUtil.downloadImage(
                    imageUrl,
                    name,
                    weight
                );

                RuneCategory category = determineCategory(name);

                runes.add(new ScrapedRune(name, category, localImagePath, weight));

            } catch (Exception e) {
                log.error("Failed to scrape rune from row: {}", row, e);
            }
        }

        log.info("Successfully scraped {} runes", runes.size());
        return runes;
    }

    private String extractImageUrl(Element row) {
        String src = row.select("td:first-child img").attr("src");
        return src.replace("/ng/img/../../../dofus", "");
    }

    private String extractName(Element row) {
        return row.select("td:nth-child(2) a").text();
    }

    private RuneCategory determineCategory(String name) {
        if (name.contains("Rune Pa")) {
            return RuneCategory.PA;
        } else if (name.contains("Rune Ra")) {
            return RuneCategory.RA;
        } else {
            return RuneCategory.SIMPLE;
        }
    }
}
```

#### 7.3.4 RuneWeightCalculator
```java
@Component
public class RuneWeightCalculator {

    private static final Map<BigDecimal, List<String>> WEIGHT_MAP = new HashMap<>();

    static {
        WEIGHT_MAP.put(new BigDecimal("1"),
            List.of("Fo", "Ine", "Cha", "Age", "Ini", "Vi"));
        WEIGHT_MAP.put(new BigDecimal("2"),
            List.of("Puit", "Ré Terre", "Ré Feu", "Ré Eau", "Ré Air",
                    "Ré Neutre", "Ré Pou", "Ré Cri", "Pi Per"));
        WEIGHT_MAP.put(new BigDecimal("2.5"),
            List.of("Pod"));
        WEIGHT_MAP.put(new BigDecimal("3"),
            List.of("Sa", "Prospe"));
        WEIGHT_MAP.put(new BigDecimal("4"),
            List.of("Tac", "Fui"));
        WEIGHT_MAP.put(new BigDecimal("5"),
            List.of("Do Terre", "Do Feu", "Do Eau", "Do Air",
                    "Do Neutre", "Do Pou", "Do Cri", "Pi"));
        WEIGHT_MAP.put(new BigDecimal("6"),
            List.of("Ré Per Terre", "Ré Per Feu", "Ré Per Eau",
                    "Ré Per Air", "Ré Per Neutre"));
        WEIGHT_MAP.put(new BigDecimal("7"),
            List.of("Ré Pa", "Ré Pme", "Ret Pa", "Ret Pme"));
        WEIGHT_MAP.put(new BigDecimal("10"),
            List.of("So", "Cri", "Do Ren"));
        WEIGHT_MAP.put(new BigDecimal("15"),
            List.of("Do Per Mé", "Do Per Di", "Do Per Ar",
                    "Do Per So", "Ré Per Mé", "Ré Per Di"));
        WEIGHT_MAP.put(new BigDecimal("20"),
            List.of("Do"));
        WEIGHT_MAP.put(new BigDecimal("30"),
            List.of("Invo"));
        WEIGHT_MAP.put(new BigDecimal("51"),
            List.of("Po"));
        WEIGHT_MAP.put(new BigDecimal("90"),
            List.of("Ga Pme"));
        WEIGHT_MAP.put(new BigDecimal("100"),
            List.of("Ga Pa"));
    }

    /**
     * Calculate weight for a rune name
     * Formula: base_weight * multiplicator
     */
    public BigDecimal calculateWeight(String runeName) {
        BigDecimal baseWeight = findBaseWeight(runeName);
        int multiplicator = getMultiplicator(runeName);

        return baseWeight.multiply(BigDecimal.valueOf(multiplicator));
    }

    private BigDecimal findBaseWeight(String runeName) {
        int maxLength = -1;
        BigDecimal weight = BigDecimal.ONE;

        for (Map.Entry<BigDecimal, List<String>> entry : WEIGHT_MAP.entrySet()) {
            for (String pattern : entry.getValue()) {
                if (runeName.contains(pattern) && pattern.length() > maxLength) {
                    weight = entry.getKey();
                    maxLength = pattern.length();
                }
            }
        }

        return weight;
    }

    private int getMultiplicator(String runeName) {
        if (runeName.contains("Rune Pa")) {
            return 3;
        } else if (runeName.contains("Rune Ra")) {
            return 10;
        }
        return 1;
    }
}
```

### 7.4 Database Schema

```sql
-- V1__initial_schema.sql

CREATE TABLE runes (
    id BIGSERIAL PRIMARY KEY,
    label VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50) NOT NULL,
    icon_path VARCHAR(255) NOT NULL,
    weight DECIMAL(5,2) NOT NULL,
    description VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_runes_label ON runes(label);
CREATE INDEX idx_runes_category ON runes(category);

-- Optional: History tracking
CREATE TABLE calculation_history (
    id BIGSERIAL PRIMARY KEY,
    session_id VARCHAR(100) NOT NULL,
    operation_type VARCHAR(50) NOT NULL,
    rune_removed_id BIGINT REFERENCES runes(id),
    rune_added_id BIGINT REFERENCES runes(id),
    puit_before DECIMAL(10,2) NOT NULL,
    puit_after DECIMAL(10,2) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_history_session ON calculation_history(session_id);
CREATE INDEX idx_history_timestamp ON calculation_history(timestamp);
```

### 7.5 Configuration Files

#### 7.5.1 application.yml
```yaml
spring:
  application:
    name: dofus-tools-api

  profiles:
    active: ${SPRING_PROFILES_ACTIVE:dev}

  datasource:
    url: ${DATABASE_URL:jdbc:h2:mem:dofustools}
    username: ${DATABASE_USERNAME:sa}
    password: ${DATABASE_PASSWORD:}
    driver-class-name: ${DATABASE_DRIVER:org.h2.Driver}

  jpa:
    hibernate:
      ddl-auto: validate
    show-sql: false
    properties:
      hibernate:
        format_sql: true

  flyway:
    enabled: true
    baseline-on-migrate: true

server:
  port: ${PORT:8080}
  servlet:
    context-path: /api

logging:
  level:
    root: INFO
    com.dofustools: DEBUG

springdoc:
  api-docs:
    path: /v1/api-docs
  swagger-ui:
    path: /swagger-ui.html

cors:
  allowed-origins: ${CORS_ORIGINS:http://localhost:4200}
  allowed-methods: GET,POST,PUT,DELETE,OPTIONS
  allowed-headers: "*"
  allow-credentials: true
```

---

## 8. Frontend Implementation Details

### 8.1 Project Structure

```
src/
├── app/
│   ├── core/
│   │   ├── models/
│   │   │   ├── rune.model.ts
│   │   │   ├── history-entry.model.ts
│   │   │   └── calculator-state.model.ts
│   │   ├── services/
│   │   │   ├── rune.service.ts
│   │   │   ├── calculator.service.ts
│   │   │   ├── history.service.ts
│   │   │   └── api.service.ts
│   │   ├── guards/
│   │   └── interceptors/
│   │       └── http-error.interceptor.ts
│   ├── shared/
│   │   ├── components/
│   │   │   ├── navbar/
│   │   │   └── loading-spinner/
│   │   ├── pipes/
│   │   │   └── french-number.pipe.ts
│   │   └── directives/
│   ├── features/
│   │   ├── landing/
│   │   │   ├── landing.component.ts
│   │   │   ├── landing.component.html
│   │   │   └── landing.component.scss
│   │   └── forgemagie/
│   │       ├── forgemagie.component.ts
│   │       ├── forgemagie.component.html
│   │       ├── forgemagie.component.scss
│   │       └── components/
│   │           ├── rune-autocomplete/
│   │           │   ├── rune-autocomplete.component.ts
│   │           │   ├── rune-autocomplete.component.html
│   │           │   └── rune-autocomplete.component.scss
│   │           ├── puit-counter/
│   │           │   ├── puit-counter.component.ts
│   │           │   ├── puit-counter.component.html
│   │           │   └── puit-counter.component.scss
│   │           ├── calculator-section/
│   │           │   ├── calculator-section.component.ts
│   │           │   ├── calculator-section.component.html
│   │           │   └── calculator-section.component.scss
│   │           └── history-panel/
│   │               ├── history-panel.component.ts
│   │               ├── history-panel.component.html
│   │               └── history-panel.component.scss
│   ├── app.component.ts
│   ├── app.component.html
│   ├── app.component.scss
│   ├── app.config.ts
│   └── app.routes.ts
├── assets/
│   ├── images/
│   │   ├── favicon.png
│   │   ├── dofus_forgemagie-logo.png
│   │   └── runes/
│   └── i18n/
│       └── fr.json
├── styles/
│   ├── _variables.scss
│   ├── _mixins.scss
│   └── styles.scss
├── environments/
│   ├── environment.ts
│   └── environment.prod.ts
├── index.html
└── main.ts
```

### 8.2 Angular Components

#### 8.2.1 RuneAutocompleteComponent
```typescript
@Component({
  selector: 'app-rune-autocomplete',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, MatAutocompleteModule, MatFormFieldModule, MatInputModule],
  template: `...`
})
export class RuneAutocompleteComponent implements OnInit {
  @Input() placeholder: string = 'Sélectionnez la rune';
  @Input() required: boolean = true;
  @Output() runeSelected = new EventEmitter<Rune | null>();

  formControl = new FormControl('');
  filteredRunes$!: Observable<Rune[]>;
  allRunes: Rune[] = [];

  constructor(private runeService: RuneService) {}

  ngOnInit(): void {
    // Load all runes
    this.runeService.getAllRunes().subscribe(runes => {
      this.allRunes = runes;
    });

    // Setup autocomplete filtering
    this.filteredRunes$ = this.formControl.valueChanges.pipe(
      startWith(''),
      debounceTime(300),
      switchMap(value => this.filterRunes(value || ''))
    );
  }

  private filterRunes(value: string): Observable<Rune[]> {
    if (!value) {
      return of(this.allRunes);
    }

    const filterValue = value.toLowerCase();

    // Local filtering
    const localFiltered = this.allRunes.filter(rune =>
      rune.label.toLowerCase().includes(filterValue)
    );

    // If no local match, try autocorrect via API
    if (localFiltered.length === 0) {
      return this.runeService.autocorrect(value).pipe(
        map(response => {
          if (response.success) {
            return this.allRunes.filter(r => r.label === response.correctedValue);
          }
          return [];
        }),
        catchError(() => of([]))
      );
    }

    return of(localFiltered);
  }

  onRuneSelected(rune: Rune): void {
    this.runeSelected.emit(rune);
  }

  displayFn(rune: Rune): string {
    return rune ? rune.label : '';
  }
}
```

#### 8.2.2 ForgemagieComponent (Main Calculator)
```typescript
@Component({
  selector: 'app-forgemagie',
  standalone: true,
  imports: [
    CommonModule,
    RuneAutocompleteComponent,
    PuitCounterComponent,
    CalculatorSectionComponent,
    HistoryPanelComponent
  ],
  template: `...`
})
export class ForgemagieComponent implements OnInit, OnDestroy {
  calculatorState$!: Observable<CalculatorState>;

  constructor(
    private calculatorService: CalculatorService,
    private historyService: HistoryService
  ) {}

  ngOnInit(): void {
    this.calculatorState$ = this.calculatorService.state$;
  }

  // Feature 1: Calculate PUIT
  onCalculatePuit(runeRemoved: Rune, runeAdded: Rune): void {
    this.calculatorService.calculatePuit(runeRemoved.label, runeAdded.label)
      .subscribe({
        next: (response) => {
          this.calculatorService.updatePuit(response.puit);
          this.historyService.addEntry({
            id: crypto.randomUUID(),
            operationType: OperationType.CALCULATE_PUIT,
            description: `${response.puit} puit généré`,
            runeIcons: [runeRemoved.icon, runeAdded.icon],
            timestamp: new Date(),
            puitTotal: response.puit,
            details: response.calculation
          });
        },
        error: (err) => console.error('Failed to calculate puit', err)
      });
  }

  // Feature 2: Subtract Rune
  onSubtractRune(rune: Rune): void {
    const currentPuit = this.calculatorService.getCurrentPuit();

    this.calculatorService.subtractRune(currentPuit, rune.label)
      .subscribe({
        next: (response) => {
          this.calculatorService.updatePuit(response.newPuit);
          this.calculatorService.updateLastRuneRemoved({
            name: rune.label,
            icon: rune.icon,
            weight: response.subtractedWeight
          });
          this.historyService.addEntry({
            id: crypto.randomUUID(),
            operationType: OperationType.SUBTRACT_RUNE,
            description: `${response.subtractedWeight} puit retiré`,
            runeIcons: [rune.icon],
            timestamp: new Date(),
            puitTotal: response.newPuit,
            details: `à ${new Date().toLocaleTimeString('fr-FR', { hour: '2-digit', minute: '2-digit' })} (${rune.label})`
          });
        },
        error: (err) => console.error('Failed to subtract rune', err)
      });
  }

  // Feature 3: Calculate Rune Count
  onCalculateRuneCount(rune: Rune): void {
    const currentPuit = this.calculatorService.getCurrentPuit();

    this.calculatorService.calculateRuneCount(currentPuit, rune.label)
      .subscribe({
        next: (response) => {
          this.calculatorService.updateRuneCount({
            rune: rune,
            count: response.count,
            remainder: response.remainder
          });
        },
        error: (err) => console.error('Failed to calculate rune count', err)
      });
  }

  // Feature 4: Manual Adjustment
  onManualAdjustment(amount: number): void {
    const currentPuit = this.calculatorService.getCurrentPuit();
    const newPuit = Math.max(0, currentPuit + amount);

    this.calculatorService.updatePuit(newPuit);

    const operationType = amount > 0
      ? OperationType.MANUAL_ADD
      : OperationType.MANUAL_SUBTRACT;

    this.historyService.addEntry({
      id: crypto.randomUUID(),
      operationType: operationType,
      description: amount > 0
        ? `Ajouté ${amount} puit`
        : `Retiré ${Math.abs(amount)} puit`,
      runeIcons: [],
      timestamp: new Date(),
      puitTotal: newPuit
    });
  }

  ngOnDestroy(): void {
    // Cleanup if needed
  }
}
```

### 8.3 Angular Services

#### 8.3.1 RuneService
```typescript
@Injectable({
  providedIn: 'root'
})
export class RuneService {
  private readonly API_URL = `${environment.apiUrl}/runes`;

  constructor(private http: HttpClient) {}

  getAllRunes(): Observable<Rune[]> {
    return this.http.get<Rune[]>(this.API_URL);
  }

  getRuneById(id: number): Observable<Rune> {
    return this.http.get<Rune>(`${this.API_URL}/${id}`);
  }

  getRuneByLabel(label: string): Observable<Rune> {
    return this.http.get<Rune>(`${this.API_URL}/by-label/${encodeURIComponent(label)}`);
  }

  autocorrect(input: string, maxGap: number = 2): Observable<any> {
    return this.http.post(`${this.API_URL}/autocorrect`, { input, maxGap });
  }

  getCategories(): Observable<string[]> {
    return this.http.get<string[]>(`${this.API_URL}/categories`);
  }
}
```

#### 8.3.2 CalculatorService
```typescript
@Injectable({
  providedIn: 'root'
})
export class CalculatorService {
  private readonly API_URL = `${environment.apiUrl}/calculator`;

  private stateSubject = new BehaviorSubject<CalculatorState>({
    puit: 0,
    history: []
  });

  public state$ = this.stateSubject.asObservable();

  constructor(private http: HttpClient) {}

  calculatePuit(runeRemovedLabel: string, runeAddedLabel: string): Observable<any> {
    return this.http.post(`${this.API_URL}/calculate-puit`, {
      runeRemovedLabel,
      runeAddedLabel
    });
  }

  subtractRune(currentPuit: number, runeLabel: string): Observable<any> {
    return this.http.post(`${this.API_URL}/subtract-rune`, {
      currentPuit,
      runeLabel
    });
  }

  calculateRuneCount(currentPuit: number, runeLabel: string): Observable<any> {
    return this.http.post(`${this.API_URL}/calculate-rune-count`, {
      currentPuit,
      runeLabel
    });
  }

  updatePuit(puit: number): void {
    const currentState = this.stateSubject.value;
    this.stateSubject.next({ ...currentState, puit });
  }

  getCurrentPuit(): number {
    return this.stateSubject.value.puit;
  }

  updateLastRuneRemoved(rune: { name: string; icon: string; weight: number }): void {
    const currentState = this.stateSubject.value;
    this.stateSubject.next({ ...currentState, lastRuneRemoved: rune });
  }

  updateRuneCount(data: { rune: Rune; count: number; remainder: number }): void {
    const currentState = this.stateSubject.value;
    this.stateSubject.next({ ...currentState, runeCount: data });
  }
}
```

#### 8.3.3 HistoryService
```typescript
@Injectable({
  providedIn: 'root'
})
export class HistoryService {
  private historySubject = new BehaviorSubject<HistoryEntry[]>([]);
  public history$ = this.historySubject.asObservable();

  addEntry(entry: HistoryEntry): void {
    const currentHistory = this.historySubject.value;
    // Add to beginning (newest first)
    this.historySubject.next([entry, ...currentHistory]);
  }

  clearHistory(): void {
    this.historySubject.next([]);
  }

  getHistory(): HistoryEntry[] {
    return this.historySubject.value;
  }
}
```

### 8.4 Routing Configuration

```typescript
// app.routes.ts
export const routes: Routes = [
  {
    path: '',
    component: LandingComponent,
    title: 'Dofus Tools - Outils pour Dofus'
  },
  {
    path: 'forgemagie',
    component: ForgemagieComponent,
    title: 'Calculateur de forgemagie - Dofus Tools'
  },
  {
    path: '**',
    redirectTo: ''
  }
];
```

### 8.5 Environment Configuration

```typescript
// environment.ts
export const environment = {
  production: false,
  apiUrl: 'http://localhost:8080/api/v1'
};

// environment.prod.ts
export const environment = {
  production: true,
  apiUrl: '/api/v1'
};
```

---

## 9. Migration Strategy

### 9.1 Phase 1: Setup and Infrastructure (Week 1)

#### Backend Setup
1. ✅ Initialize Spring Boot 3.x project with Maven
2. ✅ Configure Java 26 in `pom.xml`
3. ✅ Setup project structure (packages)
4. ✅ Configure H2 database for development
5. ✅ Setup Flyway for database migrations
6. ✅ Configure CORS for local development
7. ✅ Setup logging configuration
8. ✅ Add SpringDoc OpenAPI for API documentation

#### Frontend Setup
1. ✅ Initialize Angular 20 project
2. ✅ Configure TypeScript strict mode
3. ✅ Setup Angular Material
4. ✅ Configure environments (dev/prod)
5. ✅ Setup project structure (features, core, shared)
6. ✅ Configure SCSS with variables
7. ✅ Setup HTTP interceptors
8. ✅ Configure routing

### 9.2 Phase 2: Data Layer (Week 2)

#### Backend
1. ✅ Create Rune entity
2. ✅ Create RuneCategory enum
3. ✅ Create RuneRepository
4. ✅ Write Flyway migration script
5. ✅ Create database seed data script
6. ✅ Implement RuneWeightCalculator utility
7. ✅ Copy rune images to `src/main/resources/static/images/runes/`
8. ✅ Test database layer with unit tests

#### Frontend
1. ✅ Create Rune model interface
2. ✅ Create HistoryEntry model
3. ✅ Create CalculatorState model
4. ✅ Copy rune images to `assets/images/runes/`

### 9.3 Phase 3: Backend Business Logic (Week 3)

#### Services
1. ✅ Implement RuneService
   - CRUD operations
   - Find by label
   - Get all runes
2. ✅ Implement StringMatchingService
   - Letter occurrence algorithm
   - Autocorrect logic
3. ✅ Implement CalculatorService
   - Calculate PUIT
   - Subtract rune
   - Calculate rune count
4. ✅ Implement WebScrapingService
   - Jsoup integration
   - Image download logic

#### DTOs
1. ✅ Create all request DTOs
2. ✅ Create all response DTOs
3. ✅ Add Jakarta validation annotations

#### Exception Handling
1. ✅ Create custom exceptions
2. ✅ Implement GlobalExceptionHandler
3. ✅ Add error response DTOs

### 9.4 Phase 4: Backend REST API (Week 4)

#### Controllers
1. ✅ Implement RuneController
   - GET /api/v1/runes
   - GET /api/v1/runes/{id}
   - GET /api/v1/runes/by-label/{label}
   - POST /api/v1/runes/autocorrect
   - GET /api/v1/runes/categories
2. ✅ Implement CalculatorController
   - POST /api/v1/calculator/calculate-puit
   - POST /api/v1/calculator/subtract-rune
   - POST /api/v1/calculator/calculate-rune-count
3. ✅ Add OpenAPI annotations
4. ✅ Test all endpoints with integration tests

### 9.5 Phase 5: Frontend Services (Week 5)

1. ✅ Implement RuneService
   - API integration
   - Caching strategy
2. ✅ Implement CalculatorService
   - State management
   - API calls
3. ✅ Implement HistoryService
   - In-memory history
   - LocalStorage persistence (optional)

### 9.6 Phase 6: Frontend Components (Week 6-7)

#### Week 6
1. ✅ Create NavbarComponent
2. ✅ Create LandingComponent
3. ✅ Create RuneAutocompleteComponent
   - Angular Material Autocomplete
   - Icon display
   - Validation
4. ✅ Create PuitCounterComponent
   - Display current puit
   - Manual adjustment buttons

#### Week 7
1. ✅ Create CalculatorSectionComponent
   - "Rune qui a sauté" section
   - "Retirer une rune au puit" section
   - "Nombre de runes à passer" section
2. ✅ Create HistoryPanelComponent
   - Display chronological entries
   - Timestamps
   - Icons
3. ✅ Create ForgemagieComponent (main)
   - Integrate all sub-components
   - Wire up event handlers

### 9.7 Phase 7: Styling and UX (Week 8)

1. ✅ Apply Bootstrap-like styles using Angular Material
2. ✅ Implement responsive design
3. ✅ Add loading states
4. ✅ Add error messages
5. ✅ Add success notifications
6. ✅ Implement accordion for Help/Changelog
7. ✅ Add French number formatting
8. ✅ Ensure accessibility (ARIA labels)

### 9.8 Phase 8: Testing (Week 9)

#### Backend Testing
1. ✅ Unit tests for all services (80% coverage minimum)
2. ✅ Integration tests for all controllers
3. ✅ Test string matching algorithm
4. ✅ Test weight calculator
5. ✅ Test exception handling

#### Frontend Testing
1. ✅ Unit tests for all services
2. ✅ Component tests for all components
3. ✅ E2E tests for critical user flows:
   - Calculate PUIT
   - Subtract rune
   - Calculate rune count
   - Manual adjustments

### 9.9 Phase 9: Deployment Preparation (Week 10)

1. ✅ Create Dockerfile for backend
2. ✅ Create Dockerfile for frontend (Nginx)
3. ✅ Create docker-compose.yml
4. ✅ Configure PostgreSQL for production
5. ✅ Setup environment variable configuration
6. ✅ Create deployment documentation
7. ✅ Setup CI/CD pipeline (GitHub Actions)
8. ✅ Configure production build optimization

### 9.10 Phase 10: Migration and Validation (Week 11)

1. ✅ Deploy to staging environment
2. ✅ Run full regression test suite
3. ✅ Performance testing
4. ✅ Security audit
5. ✅ User acceptance testing
6. ✅ Fix any critical issues
7. ✅ Create rollback plan

### 9.11 Phase 11: Production Launch (Week 12)

1. ✅ Deploy to production
2. ✅ Monitor application logs
3. ✅ Monitor performance metrics
4. ✅ Gather user feedback
5. ✅ Address any immediate issues

---

## 10. Testing Requirements

### 10.1 Backend Testing

#### Unit Tests (Target: 80% coverage)
```java
// Example: CalculatorServiceTest.java
@SpringBootTest
class CalculatorServiceTest {

    @Mock
    private RuneService runeService;

    @InjectMocks
    private CalculatorService calculatorService;

    @Test
    void testCalculatePuit_ValidInput_ReturnsCorrectResult() {
        // Given
        Rune runeRemoved = new Rune("Rune Pa", RuneCategory.SIMPLE, "path", new BigDecimal("90"));
        Rune runeAdded = new Rune("Rune Vi", RuneCategory.SIMPLE, "path", new BigDecimal("3"));

        when(runeService.findByLabel("Rune Pa")).thenReturn(runeRemoved);
        when(runeService.findByLabel("Rune Vi")).thenReturn(runeAdded);

        CalculatePuitRequest request = new CalculatePuitRequest("Rune Pa", "Rune Vi");

        // When
        CalculatePuitResponse response = calculatorService.calculatePuit(request);

        // Then
        assertEquals(new BigDecimal("87"), response.puit());
        assertEquals("90 - 3 = 87", response.calculation());
    }

    @Test
    void testSubtractRune_NegativeResult_ThrowsException() {
        // Test logic...
    }
}
```

#### Integration Tests
```java
@SpringBootTest
@AutoConfigureMockMvc
class CalculatorControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void testCalculatePuitEndpoint() throws Exception {
        mockMvc.perform(post("/api/v1/calculator/calculate-puit")
                .contentType(MediaType.APPLICATION_JSON)
                .content("""
                    {
                        "runeRemovedLabel": "Rune Ga Pa",
                        "runeAddedLabel": "Rune Do"
                    }
                    """))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.puit").value(80));
    }
}
```

### 10.2 Frontend Testing

#### Unit Tests
```typescript
describe('CalculatorService', () => {
  let service: CalculatorService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [CalculatorService]
    });
    service = TestBed.inject(CalculatorService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  it('should calculate puit correctly', () => {
    const mockResponse = {
      puit: 87,
      runeRemovedWeight: 90,
      runeAddedWeight: 3,
      calculation: '90 - 3 = 87'
    };

    service.calculatePuit('Rune Ga Pa', 'Rune Vi').subscribe(response => {
      expect(response.puit).toBe(87);
    });

    const req = httpMock.expectOne(`${environment.apiUrl}/calculator/calculate-puit`);
    expect(req.request.method).toBe('POST');
    req.flush(mockResponse);
  });
});
```

#### E2E Tests (Playwright)
```typescript
test('should calculate puit from two runes', async ({ page }) => {
  await page.goto('http://localhost:4200/forgemagie');

  // Fill first rune
  await page.fill('[data-testid="rune-removed"]', 'Rune Ga Pa');
  await page.click('[data-testid="rune-removed-option-0"]');

  // Fill second rune
  await page.fill('[data-testid="rune-added"]', 'Rune Do');
  await page.click('[data-testid="rune-added-option-0"]');

  // Click calculate
  await page.click('[data-testid="calculate-puit-btn"]');

  // Assert result
  await expect(page.locator('[data-testid="puit-value"]')).toHaveText('80');
});
```

---

## 11. Deployment Strategy

### 11.1 Docker Configuration

#### Backend Dockerfile
```dockerfile
FROM eclipse-temurin:26-jdk-alpine AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:26-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/dofus-tools-api.jar app.jar
COPY src/main/resources/static/images ./images
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

#### Frontend Dockerfile
```dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build -- --configuration production

FROM nginx:alpine
COPY --from=builder /app/dist/dofus-tools-frontend /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

#### docker-compose.yml
```yaml
version: '3.8'

services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: dofustools
      POSTGRES_USER: dofustools
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  backend:
    build: ./backend
    environment:
      SPRING_PROFILES_ACTIVE: prod
      DATABASE_URL: jdbc:postgresql://postgres:5432/dofustools
      DATABASE_USERNAME: dofustools
      DATABASE_PASSWORD: ${DB_PASSWORD}
    ports:
      - "8080:8080"
    depends_on:
      - postgres

  frontend:
    build: ./frontend
    ports:
      - "80:80"
    depends_on:
      - backend

volumes:
  postgres-data:
```

### 11.2 CI/CD Pipeline (GitHub Actions)

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  backend-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          java-version: '26'
      - name: Run tests
        run: ./mvnw test
      - name: Build
        run: ./mvnw package -DskipTests

  frontend-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - name: Install dependencies
        run: npm ci
      - name: Run tests
        run: npm test -- --watch=false
      - name: Build
        run: npm run build

  deploy:
    needs: [backend-test, frontend-test]
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to production
        run: |
          # Deployment scripts here
```

---

## 12. Timeline and Milestones

| Phase | Duration | Deliverables |
|-------|----------|--------------|
| **Phase 1**: Setup | 1 week | Project scaffolding, configuration |
| **Phase 2**: Data Layer | 1 week | Database schema, entities, repositories |
| **Phase 3**: Backend Logic | 1 week | Services, algorithms, utilities |
| **Phase 4**: REST API | 1 week | Controllers, DTOs, API documentation |
| **Phase 5**: Frontend Services | 1 week | Services, state management |
| **Phase 6**: Components (Part 1) | 1 week | Basic components |
| **Phase 7**: Components (Part 2) | 1 week | Complex components, integration |
| **Phase 8**: Styling & UX | 1 week | CSS, responsiveness, accessibility |
| **Phase 9**: Testing | 1 week | Unit tests, integration tests, E2E tests |
| **Phase 10**: Deployment Prep | 1 week | Docker, CI/CD, documentation |
| **Phase 11**: Staging & Validation | 1 week | Testing, bug fixes |
| **Phase 12**: Production Launch | 1 week | Deployment, monitoring |

**Total Duration**: 12 weeks (3 months)

---

## Appendix A: Current vs New Technology Mapping

| Current | New | Purpose |
|---------|-----|---------|
| Vanilla JavaScript | TypeScript | Type safety |
| jQuery | Native TypeScript | DOM manipulation |
| jQuery UI Autocomplete | Angular Material Autocomplete | Autocomplete widget |
| Bootstrap 5 | Angular Material + Custom SCSS | UI framework |
| Font Awesome | Font Awesome 6 | Icons |
| Python scripts | Java + Jsoup | Web scraping |
| Static files | Spring Boot + Angular | Application serving |
| Client-side state | RxJS BehaviorSubject | State management |
| Local JS array | PostgreSQL/H2 | Data persistence |
| None | Spring Data JPA | ORM |
| None | Flyway | Database migrations |

---

## Appendix B: Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Algorithm translation errors | Medium | High | Thorough unit testing, side-by-side comparison |
| Performance degradation | Low | Medium | Performance testing, optimization |
| Data loss during migration | Low | High | Comprehensive backups, migration scripts |
| Browser compatibility issues | Medium | Low | Cross-browser testing |
| API design issues | Low | Medium | OpenAPI documentation, early testing |
| Timeline overrun | Medium | Medium | Agile sprints, regular reviews |

---

## Appendix C: Success Criteria

1. ✅ All 5 calculator features work identically to current version
2. ✅ All 103 runes are correctly migrated with accurate weights
3. ✅ Autocorrect algorithm produces identical results
4. ✅ Page load time < 2 seconds
5. ✅ 80%+ code coverage for backend
6. ✅ 70%+ code coverage for frontend
7. ✅ Zero critical bugs in production
8. ✅ WCAG 2.1 Level AA compliance
9. ✅ Mobile responsive design
10. ✅ API documentation complete and accurate

---

## Document Version

- **Version**: 1.0
- **Date**: 2025-11-08
- **Author**: Claude (AI Assistant)
- **Status**: Ready for Review
- **Next Review**: After Phase 1 completion

---

**END OF DOCUMENT**
